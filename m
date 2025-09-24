Return-Path: <linux-kernel+bounces-830983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AACB9B130
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE52380D60
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 17:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F609314A97;
	Wed, 24 Sep 2025 17:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qg20STHz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ci4or4I5"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DF419ABD8
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758735256; cv=fail; b=nC2Pn6z77rPp8Vg1bjr51VCttbqRzCthdurDyJXGPMaDz2t0kEsNOjrQFPEbu/6wPHQcBY8X1uem41OzaK8cwrkWIY9BeJ1yIYqQVg88PtP1bS/m8aLnm6u+1GSIXH/oy0x/3fGnPzx51PY3b+jmoklJwIzCVevLZuJ2Oge5jYo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758735256; c=relaxed/simple;
	bh=/87CN/uM1sWnjBZMc2bgatWAiJ7b5IsjbnUkBUSJtV4=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Cay/zqLGAoV2X+XuUnxeiWXuuIhLBgEiZIY8yx1lwfSk2Ah8Ugqm8Xvi8EqB8ZpAHPeY09F/AZcwt08cT91ey3LqkVdBkdJYLmaUgCEjQGjQZsfMnbDNEo2K+CpIk2DASKaz1cAcLsWtedabggR1FZYRPEslh/4KH2irDubwEFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qg20STHz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ci4or4I5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OFMhJH010437;
	Wed, 24 Sep 2025 17:34:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=X2TKmlc5Hel/wgPRes9suxd8GbNPYPNAigUFbIXMuOc=; b=
	Qg20STHzcUCsU11kEabPMSV7P4tkzg3f0ght4SKatxVyK65hvgVWqGS0Jd1tJw+2
	y47FbXJI5o0Vy4kps0ZlHfwMHlsFXAChufxRsdMUr4qpF9NTwP5fdCybAnM8waAa
	dirS4jEXMofldR9pTP0MJA2GBtEP+6OI0xQCxul4hacOfTjkdtJm2ctyAUJtD/Eg
	EnTwJ1JeSMi7NplxkNgg9HPboWCndvh7VVngK1+pGD/WpON//v+eQzNKHM0JIEO8
	fiNPD25/m2P8O4gYoUJE2M6YYulDZ7zxmYGQdsp0Uk5vLvmYH1ryMK3T7sFo785y
	982ah5DqAoaa8fJwcZngzw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499jpdr6s2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 17:34:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58OGvRam000388;
	Wed, 24 Sep 2025 17:34:07 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011044.outbound.protection.outlook.com [52.101.57.44])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 499jq9wgag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 17:34:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kUJaD9hDZcBGraz4Op32RWzJojT9Hwudhc6XuqAbwk8YTyVHVap8xAAq2qeQ6zbE93Hga5k75RIUgCXhdlA+vyw3DWZlgCJriZZG2Oby5Bt/rVvxX0Yy09WJn9uZUU1FfByy0LSrCeaZK3O6rDdAtK+AbbKL8PBlU8IuCtg0wa0dUvWShxGtcl1O+UT7LYsj9xq6fipz4R2l5jRw62AbPFeoGmXKYjM90XdnAWEInkmo4fu6TkCoHLoQVDwEOI7QGqcw4nlU5bnlVOiIJpgoAVgVzokr1yzdMFdTqUafsnGp+/Sv1RVOlM3KJQoOljfa6877FoBeZCFNw4tsEm0gKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2TKmlc5Hel/wgPRes9suxd8GbNPYPNAigUFbIXMuOc=;
 b=f5ScCvEqLu86S1g8+O38LRLJhOmQxaOPTmOJiZOZeOSSSzMLpxfIVvXNIvSuiLKlpgD0ngpnLQtugc5Ho12TM6zx7PCmwOBm2byE6CUcZEtYSoEeg6KdaQA88Qx6o/ZRUED7WonqQtv0clNIJI9f0QCVOwIVkz9L0rV5QJhVo6+R0/LZRq4fytPUQEXnIy776SGUztQqAgGofbSuRepKBRr2db0X4hy79ChZ0P9bbDuwhE5kHlILA4c7EDrSIpK4VQNgKsR3FPrV1CjZt2f4rKfAnqPQ9A8WoFo0UWfAw24ryuSRgVN2BpqQ+6JQSwtsswa2ahjnWgIMf1Ceem5Ybw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2TKmlc5Hel/wgPRes9suxd8GbNPYPNAigUFbIXMuOc=;
 b=ci4or4I5hiHuY3enXPOsd2tUgIgCM3zMBtL+LKw6tQA3cuMl4Jc0l13P59DP48nvyPqgfSireGGb/CxaJMEo1VXymnv2BfFQhOwy65uVHoihWzZ1vDYsUPeXEhJZFmq4NlfSz5qDlYxgrF6jLaGyhtyFijj517BdbUsjYCQYswo=
Received: from SN4PR10MB5622.namprd10.prod.outlook.com (2603:10b6:806:209::18)
 by IA3PR10MB8018.namprd10.prod.outlook.com (2603:10b6:208:50b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 17:34:02 +0000
Received: from SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084]) by SN4PR10MB5622.namprd10.prod.outlook.com
 ([fe80::6bce:37ef:d1de:d084%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 17:34:02 +0000
Message-ID: <b6aaa53d-2658-491a-9308-32ae2b5aefb1@oracle.com>
Date: Wed, 24 Sep 2025 19:34:00 +0200
User-Agent: Mozilla Thunderbird
Cc: alexandre.chartre@oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] objtool/x86: Fix NOP decode
To: Peter Zijlstra <peterz@infradead.org>, jpoimboe@kernel.org, x86@kernel.org
References: <20250924134507.288529132@infradead.org>
 <20250924134644.154610650@infradead.org>
Content-Language: en-US
From: Alexandre Chartre <alexandre.chartre@oracle.com>
Autocrypt: addr=alexandre.chartre@oracle.com; keydata=
 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
 swLliy6PdpST
In-Reply-To: <20250924134644.154610650@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0014.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::19) To SN4PR10MB5622.namprd10.prod.outlook.com
 (2603:10b6:806:209::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR10MB5622:EE_|IA3PR10MB8018:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a6a1165-89a9-4f00-dd23-08ddfb908da0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGhnS1JFZVQra1V6S3JIOUJkLzlydEtRU0hIMlp5L2RLRHplQkxjWFdPTzRN?=
 =?utf-8?B?OXhDNVhycktvdU03WXNtZ2dUSWpaMmZscmJwNU9yWlExRURoRngxUlM0dVd3?=
 =?utf-8?B?U3VTSGgyMXpXaGE2VUlEV2JMZVpXRmdKTFJhTjNFNkw1dHRKdkVxVnF5RXFR?=
 =?utf-8?B?cDRXNi9YOHhpeGRnMERMdVp1VmdNL3pOajBtbnZwYVdTVkNBbjhxRU9qS0RX?=
 =?utf-8?B?TXIwUElNV2JPT09DbWhTWmpaZ0VCaGJLWEhXWGRaa0JBV3d3NUtRdXFWcVVj?=
 =?utf-8?B?R1NITndUSGNiMkluM3dOc0cvSTg5ZHlpbzlrT1dDWE0rQTM4NWVBRVZYM3JJ?=
 =?utf-8?B?c09oWHF4aVlJQmtyMTBBLzJ5K3lPbWJmUWlZRm9RSWJlYTlrTm85cWlCaFgw?=
 =?utf-8?B?OVA0eGFkVGJnUDhqMzJDdFZXMEh0TDVrQUtWNGN2SGRQbVdIeTh6MzRBcWpa?=
 =?utf-8?B?R1QvV2hnVHFrNEt4VE5KdTBrVGpmeUNjK0NOWjlyQ0g5bEZlaEFHWThkVElZ?=
 =?utf-8?B?R1AyMmI0Z0NDQXgrSkFSTk9FMmpIcTRMSTdRWm9TajV5b1RsOFc1bm9MT3NM?=
 =?utf-8?B?OFpTcXdQTUJJVkl4RDdCZVJNcWVMWHFHVHV2K0FKaTFiOThYN0lIc3dpQUN6?=
 =?utf-8?B?V2JSUk4ra1hSM2pXeTJLRzVmTUd0b0VWNEdTRjdrWExBSmhlNDF6dFFuZERW?=
 =?utf-8?B?VFBUYjFBQVhidklOM0xiV011NXhtb3lCZ0pSMEdpRzYxUVBlMGc5aE9COGxQ?=
 =?utf-8?B?UGtBck9wdnUyNjRGUkN1QTIrVjFjOUUzUm4yWG8yTHRKSVl4QW9iVVN3Umwr?=
 =?utf-8?B?K0FSYlJzQ3VFUmpQa3FrTDlXYjNoUEltbkRRMjMwSVlkcFkvRU9jMnl3SDkr?=
 =?utf-8?B?dEE1cnQxZmNFK09aRTZXVllMdndpVlRoSlFlV2gzNk5KamxrYUNCM0wwQ3FH?=
 =?utf-8?B?WjdNZ3VSN2ZKdXFUNzE2S0twcm5BUEJVZzFiaXZqZXFUSFlRYXJMN3ZObDFV?=
 =?utf-8?B?cEoyd1NtdmNMd00xa1hQVGNhWFd0WGordVUzMTJrWDBmVy9BSS9aRG5EV0xx?=
 =?utf-8?B?bTVaUHEvRGI3OGhneHlxNWdyVzNrcjFsY1J3Z2pEZWFFZEhNdFJZOTRJWGFs?=
 =?utf-8?B?N0E2bTd5WGZmOVJ2RDFWMUtGVmJjTGVQS2ZlL1BJMmNEMU9sQ2tZQ1hNdVpx?=
 =?utf-8?B?cnVvcWNjTDBPY2JLRjdpOGREQWNVbXhPNkMyaFZzaWphMEpYVjJhWDNVTkN4?=
 =?utf-8?B?UHIwMDluakFrQXRqbHFRTFlhYkZnRzZZM2U3RFZPdHp3cTZGa0lleXI1TjlU?=
 =?utf-8?B?ZWNrekRSTWZDZGpCKzJsY3N4eFZIOFd6ZC9hQkhvZldrakloN3ZuZElyWVRv?=
 =?utf-8?B?RnhCbXlDSXBBK0NZS1l5UWMwSS9NSHo2RmJ6SE1wak9wSGNocWxOdjJxZ3gz?=
 =?utf-8?B?cE1aZkxULzduQmhOcUdhMDlzOFBIb05HQWlSZzZSQ2pTQ3VCQkRvbUwrRU1h?=
 =?utf-8?B?ZlV6SXBjalduc3ZOcUdyWXJkZ1g3UkxCcjlVaTYzcXF6NlpPeU9pUHRQWFRI?=
 =?utf-8?B?OWc0WHhwbG5BaXdsQWk0dUJNNHlpZDF5Yk4rZUZ0Zm5YWkJyWjQrcDR3a1Fh?=
 =?utf-8?B?UXozS3pFUmU0K1ppTnRvbTYxM2VXZE84dlh6djNoS3h4eStzZEt6ZzM4SmdQ?=
 =?utf-8?B?VDFsVGI3RVdNVU1Pazh1aE9PQ012VkI4dGhQeVVtTlV5QkJjZ2VXaTdtMUdK?=
 =?utf-8?B?K0x2QTNFY3MyQW5IZndyQTdFWHQ3dWl0MUdKV1kxdmpFQ0dUdTQrUVNXSG4r?=
 =?utf-8?B?eVVuaXFsMHhnSU5ObHdIVFhwUkxGSjZZc1lhUi9teHVFR3FUaDUrWkxkRXdZ?=
 =?utf-8?B?YkFaZkF6MFUrM3VVeHVrWVJJeThONHJQWGJrYXoyaitHSGNIZHBjMHEvYlJY?=
 =?utf-8?Q?dbWVY7hd0x0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR10MB5622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWxoZVZ1aEFyK0RXd2kwMHFEaG5pUlZuK1M2aXJlbEJXNkJRTDUrQW95TlBR?=
 =?utf-8?B?RDFPSitVZ2pYVXZqdUp4UE9FSm9QNzNQWjFHY3pCbXBqMGdtamhuY0Jvei9D?=
 =?utf-8?B?Qk81dy9TNXRKZmRpK0ZzUFJ3LzFrMGx4d21kbUZ2c2laaDNrL0tCNWtCSEEx?=
 =?utf-8?B?TVlML2ZmdjBHTlROM2hyZHhrL2VWVEpuYmNCbEpYK1BjVkxNZDJRbVFqNjJj?=
 =?utf-8?B?UmN4ZVByVjh6QWtHSUg1MjNNTGc3Q3lwRm5LVWhpLzlyUGF6UDM3elVBZTl5?=
 =?utf-8?B?b1RqYllSWm1XSlNzQUI4STdZcGtiUUFnNU0zN2tnOVptd0R0OW1TaGcrUXJP?=
 =?utf-8?B?ZDlvaXBWbXF6MU5xTkhMQzVxNGRZQVh5aWFjR0xYdmVFSURPbkwyaXdmd0xE?=
 =?utf-8?B?M1U2MWNsQ3orVXpUY1NNOWVrbTd2dlR5c3BOalF3QUk1NHNwOG9wOC95VkZK?=
 =?utf-8?B?TVZYMXZwOGJXdzAwNUlNSFpIcjRROTVZU0hGNDQ1dWM1aXNIWkJnNVEwQ0ha?=
 =?utf-8?B?NmpvV28rVGQ2WVhnUVNnMlkrK1BWU283L2JaOFJxYkZ6TlV4Z0ZEaTNSME5Q?=
 =?utf-8?B?KzU0ZmJ2c0F5bVRCVHczNXVSMlNsVWYyc3dPTFNIWFk2QTUrQyt1WVRZWnFO?=
 =?utf-8?B?R2wzdVV6M3EvdjFUejUwalg3SHBRQStpNUFhWExHNWFCQnIyZnU3cVowSm9L?=
 =?utf-8?B?b3JjTGM4dFo1clU0bk5vS2swb2ZCemMvU014bFNiSWxTRXIwWkNMR2RENkFZ?=
 =?utf-8?B?Mlh1TXVFNE8yREozRHROTkpuKzEyMFZHcGFBakhHcTJtMXJhMC9mMXZJdTUz?=
 =?utf-8?B?NUV2VnRwWWdSN0pZU25lNzJwTmx5WjNwWFFvQ2prWTFhU2ducDhJWmZpOVZq?=
 =?utf-8?B?elRqUERVWkM2a21LeGYrazZIdDVhS1AxZDhXQUg3c3FLYTRvclk4ME9JQi9h?=
 =?utf-8?B?M0h3K2s5MlMvWUY3Y3kzcThmbGdSY2NpZnFLWEdSSDBMMUx4UzYvcWIyYnZD?=
 =?utf-8?B?RWUzU0RMVFRUc1R3VURwRDM3c3Jpa0hoU3JlNXNmRUtodXQ4Y0FteURKVTAv?=
 =?utf-8?B?dFNHK2YxeXdEay9BNzlSS0dYaXh6b2htUmQxWjYvdnRBN2VtZlIvcFZYYnk2?=
 =?utf-8?B?ZEI3YzN4SFdPY2hQREtGNDhYSlNLZkJYNWpVWHNrS0RTZEJ2SHZSY1RFU2pK?=
 =?utf-8?B?ZHpPczVXdm02RGE4Vm5TdUxOc1d3dTJDZU0zbnc3Z3U0OUpMcjRFRDRZYnc2?=
 =?utf-8?B?REtDWDdraS9sNVNRUHhDSjN6cXZaZFZCY1BoT2ZhbGxHV3FNVHEwdmlrSk5W?=
 =?utf-8?B?elNpc21NVElmRGpBdEhqczBmSHg2ako1UEt6SGt3WUhnUWU5ck9sMEpkWXRE?=
 =?utf-8?B?bWhZUEFFVHR1cUlRRGtib0tBTHZZMC8wVWlMVXRXbFpCb0tZejhBLy9VcjVD?=
 =?utf-8?B?Rlh3TlBkYkRnTjFxenUwT25Ga3Y4WXYwbWN4T25kdDh0VTNTNkpnV3dnUzhC?=
 =?utf-8?B?bG15ZUlFZG9Zb1NrRjhLL0VHbVhybS9CR0dFdVlPeExWVlVKalA0Umx3ZUp5?=
 =?utf-8?B?bXZGUElwdTVPcWw4S0FvUkM5UURTWTZVWThZbjB3S2Yxc05xOEg0YXhGV0E2?=
 =?utf-8?B?REZwRURDeGtCUkk1Mk94L2FhdVg4aXRvR2RLb0JFTkMwdkExSXR3a1lVcmQ0?=
 =?utf-8?B?WnZob0M2RHBZZlpTeUY3SVYySFpWeGhaaXVaZkpWbis2bktuRHZtTVIrTFFw?=
 =?utf-8?B?czNaRjRBVHlxWC8wRGdydit3UjFFanNEZWlNQit6YURmUjFRYnpUS285OEZy?=
 =?utf-8?B?bG5xa0QzdjJnUzlNMkVET0Z4K1NlYWg2SGdIdkMrN0hYOU9tSXF6MmZXeUJt?=
 =?utf-8?B?MlFLVmxidzZ0aUNxNHFQMU93NThVNVF0aU1XQ3VXdmhTcGlrLzVZb090OG5q?=
 =?utf-8?B?cHpBcnlrcmxmR2FJaFBYbFo1ZG1BZTZCNmZNYVdpZ2ZIb0k5NmZqbllyMFRH?=
 =?utf-8?B?STZ1RG5BNWk2Qjd4UmV1MDVLY2JyVkVTd0w4MjM1RTZyYjNrMmwwVDgzZTVr?=
 =?utf-8?B?MmszNjJBRyswOXo5ZFgxek14cytldlhkdGhHWHVQRE1ER0luVFlZcXBqaDdn?=
 =?utf-8?B?eUNzL2hELzVEVG1VUWtvOG55bVlBZ2JkTmpCc2E3ckJxcXdPMjZvTlFvdGhU?=
 =?utf-8?B?VzlMdnNPam9sV1dKMmMxemV3NzFJTzU2ZEh2bWJveUFOa2tpMExJU1JlT1NH?=
 =?utf-8?B?S21MQzAxWm42cDFYSXltVHJLV2NnPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	m2pCxcJWJUwQgTg32gvZIbXxlcttQ3fDH3sMF0mFzs5p401dP4AfcyxwfRE+AxT8UcTaJ1oDz4RoPL1b5/UhWinRlFg3sOpqt3CLIp7T15U3IN+pYfTVODGoUTU/+45VTya2GhPgVz0UsdvzqrRX5TUYZHHm4GjUSMCLfZTzleKS8R7vvlZL7IJZAzXG8si+Ml1Qi3mCxCxf77fABZGRvCB1+ZiVxc2mZ2U63ipG+CuBdj15y6y573ibJsgcwPEpisdZeGnqKZMoDyWLiT6XFCTtOZaCMUnTdcpy/PplkdBh3Wfq1bZeyFnHyj/gLcKxEHaejBlpmouTUqZU8o1IBFL0fskI3zCsp14rb9IT7o45WM7ZKyuoYpXgzUTWE8VOotlO79hWAs/oqjDoNp3n07arcCXGB0fzhfLC1ka+6bIhILw5z8sW8IoJrWgkYIxkQPxLsjpCb6BjKSitmKucOnM63T3mc4zz6cuYOUz3WiPOfVz2FrWY5jezGvpszrhrG4fgq5IKSNIFSyUwqw2n+WRZc1dnym8ZMkrjRUojF3QJpcGXGu6uXHj0n5D7y6U5XVX8ipv2FNUp6GkaQaS8JTFhWuBFEO8wkss0Q6KcXE8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a6a1165-89a9-4f00-dd23-08ddfb908da0
X-MS-Exchange-CrossTenant-AuthSource: SN4PR10MB5622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 17:34:02.8017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GxL21M9/0W5OKccEp/mErBOPVjfvbyh9he9q80LG9vwQNALWrWwbajjSh2sCNkvqXXjiNxStPUynNoGYwp29aI8xOBrsAqu3KvT2DURrRZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8018
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_04,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 mlxlogscore=975 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509240152
X-Proofpoint-GUID: r1GR38KkYSQ85b1XrIypw1HWgGpwxvH2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxMiBTYWx0ZWRfXyrlSZsxSBWZv
 OsLASAWWOvBAk8OijqSepl5v2k8GkrdZomjvXvqsDrGVe2xAiiwN+TdVsi2aOeoC9J8UZU1UQGL
 uMWDch5n9dVONGDUMWe7JmQBiMZyJHOkJnSd3bUuhdbPh14bnWJ50Up0W4nMX5l/MtxyrlWdYH9
 4D3pORedQ1VgpmTSR8xHfiha+na5TZSwDHECbYdTCw50+PW9upI5WfuUdje5TFix1q2tKVp7GT+
 Vn3AIh363HOaP3GM7BRYbutJ+rUvNoOsok38wbkZFoTtFCkEFC1yOhDfEChO4kuO3ePTTslBodS
 5kHF+hDJE1B+WgIArGbOY+Wflyw42edgWi8sDzn07SU88kqDiJQFyuYO+ti+oYYBS4TIPJiTrv9
 D1lhkx4D
X-Authority-Analysis: v=2.4 cv=aJPwqa9m c=1 sm=1 tr=0 ts=68d42b90 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=JfrnYn6hAAAA:8 a=QHlzsh43FKln0nenNf0A:9
 a=QEXdDO2ut3YA:10 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-ORIG-GUID: r1GR38KkYSQ85b1XrIypw1HWgGpwxvH2


On 9/24/25 15:45, Peter Zijlstra wrote:
> For x86_64 the kernel consistently uses 2 instructions for all NOPs:
> 
>    90       - NOP
>    0f 1f /0 - NOPL
>
>
> Notably:
> 
>   - REP NOP is PAUSE, not a NOP instruction.
> 
>   - 0f {0c...0f} is reserved space,
>     except for 0f 0d /1, which is PREFETCHW, not a NOP.
> 
>   - 0f {19,1c...1f} is reserved space,
>     except for 0f 1f /0, which is NOPL.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   tools/objtool/arch/x86/decode.c |   12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> --- a/tools/objtool/arch/x86/decode.c
> +++ b/tools/objtool/arch/x86/decode.c
> @@ -494,7 +494,8 @@ int arch_decode_instruction(struct objto
>   		break;
>   
>   	case 0x90:
> -		insn->type = INSN_NOP;
> +		if (prefix != 0xf3) /* REP NOP := PAUSE */
> +			insn->type = INSN_NOP;
>   		break;

So this covers NOP1 (0x90) and NOP2 (0x66 0x90), right?

>   
>   	case 0x9c:
> @@ -547,13 +548,14 @@ int arch_decode_instruction(struct objto
>   
>   		} else if (op2 == 0x0b || op2 == 0xb9) {
>   
> -			/* ud2 */
> +			/* ud2, ud1 */
>   			insn->type = INSN_BUG;
>   
> -		} else if (op2 == 0x0d || op2 == 0x1f) {
> +		} else if (op2 == 0x1f) {
>   
> -			/* nopl/nopw */
> -			insn->type = INSN_NOP;
> +			/* 0f 1f /0 := NOPL */
> +			if (modrm_reg == 0)
> +				insn->type = INSN_NOP;
>   
>   		} else if (op2 == 0x1e) {
>   

And this covers all other NOPs (0x0f 0x1f ...), including NOP6 which has
a 0x66 preifx (0x66 0xf 0x1f ...) ?

 From arch/x86/include/asm/nops.h we have:

/*
  * Generic 64bit nops from GAS:
  *
  * 1: nop
  * 2: osp nop
  * 3: nopl (%eax)
  * 4: nopl 0x00(%eax)
  * 5: nopl 0x00(%eax,%eax,1)
  * 6: osp nopl 0x00(%eax,%eax,1)
  * 7: nopl 0x00000000(%eax)
  * 8: nopl 0x00000000(%eax,%eax,1)
  */
#define BYTES_NOP1      0x90
#define BYTES_NOP2      0x66,BYTES_NOP1
#define BYTES_NOP3      0x0f,0x1f,0x00
#define BYTES_NOP4      0x0f,0x1f,0x40,0x00
#define BYTES_NOP5      0x0f,0x1f,0x44,0x00,0x00
#define BYTES_NOP6      0x66,BYTES_NOP5
#define BYTES_NOP7      0x0f,0x1f,0x80,0x00,0x00,0x00,0x00
#define BYTES_NOP8      0x0f,0x1f,0x84,0x00,0x00,0x00,0x00,0x00


alex.


