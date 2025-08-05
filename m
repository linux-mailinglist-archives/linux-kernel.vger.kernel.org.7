Return-Path: <linux-kernel+bounces-756261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D352B1B1FE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127F618A05BA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E994156237;
	Tue,  5 Aug 2025 10:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aaTk5zTQ"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2087.outbound.protection.outlook.com [40.107.96.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F77826C3A0
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 10:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754389666; cv=fail; b=GjsH/esfIY5AUNYR5vybYVF402oFaFKAqCdw45Q17xblZSZjxQxd7cQPdkxJPiB6mvHJ/z8xyfghwCGwhYxDqxCjPIc8LWIzvJ0uWMz2WGPG8pe5HfVkcvDSS9rAl1EV6tFVyx8d8HPjqRf3gKxkTa8GGLFF4BI1N27orJfaM68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754389666; c=relaxed/simple;
	bh=UYhEkvRR13tRzV4JycJy/QH27d5YzzMgXTgjPvtOLQQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pTTYp+8ALqUj5WWVhUB9YIDkEOxrEosaGxl7WlnaHuiIq3BNVPhOfNRX8waWizSy7FqU0tV1PwYOWhAhm3LkCaWz4xqd4A1MuiXJF1x0tBgOv3TFf4EoPTC9u0BQR+6CbzyFBJfMoFtFBrXdCGrBy/Jc2FKJkexeYxYI9iCbpwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aaTk5zTQ; arc=fail smtp.client-ip=40.107.96.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPp3T8RY+e/OXYGy87n49eba3updEh49WZgawRJOBwwLk3GpeeQerY0QnBF32mEmtKk9pfDVmxt9fbA9hUWj8L9FsYiyl+1qyymCdAJhPK2DjpUxkHOWFD9qBwHOYtddnGtKFBo515S8aPWqVcQfKoZHOv4EO+21eDnae4DAAvqQ8E/Kd34MHU/esVwC71ox24CQ4rpg7FoTvhD4ympongkpdyafcsi0owkh+xSE+SXi/gQ3tPkIaCsGsxFugHJTZiSeI+8VlONUke/WLGBGJfUfSkYX5rsEqFq1smelO6aHUn9yq3flAFNMW3VQx6b+tslNSUVRzaXvE9hU4nDJgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcg7leytIasRmVhVrpDGy1XsrLFo3CkkQKe9zDjABl0=;
 b=HhNaAfdzR/SKK6NHZOoLn1goSG61kM9xdpoZsuzC2heawNyOK7TJXNBCGi36YS/D3XQSz6CfdUmXE8SyD1q0h78oY0Sisl2RR97HjexZOnwaTYTUBZBY/HvUq1CDeKe21TfXgxq1BkmSQcNq/mH80q60waW+/CXzYjbfBYtdzaPCAGg0bmXT6aqxLXLyuwY79AYhgVeRszdcH9/aUWE1R8oNgdb4/N4sD/lDp0iEzko2UaWHwsceUfZjrx8ZsAlTPaYdxzKmtbUfy/SvOM+UKLQMYFqjlYkZ/u6Kj4Yi+hOKYRyajP92+jwDkJBMu7zgeGOOOxhKqb9F2pvkanJZZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcg7leytIasRmVhVrpDGy1XsrLFo3CkkQKe9zDjABl0=;
 b=aaTk5zTQXytMPxCrB/Bim4Sgn4JpwNZOjfAE1kwQ2Wv5+HWxBlKXvEFTCl+wnCqLo6698E/VxEVy/zxrHckpSl9R2xoOKlqob7NM698ewEVASbPIQH67k6yTkxcdMNAwOk8iCpC6HdoEe9XXY87yj7G/nqpLDiYzOmC5a9eU1POGITINJN60MfxCqwVH7sz0gfaz5VUETQ3vH5/fzIkYsPjppaUqVDhpVaZJHPBMfJJN9fW7uStJK6G0OtvrEbIkBb9aCqkp/CSawxBfqxyhS30ytj7krtVKS8jAVAPFEFFFJrjv+YL8g2urvnU9frz5kyXtUs8zuWAefTlkT8WFeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by SN7PR12MB8789.namprd12.prod.outlook.com (2603:10b6:806:34b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Tue, 5 Aug
 2025 10:27:39 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%5]) with mapi id 15.20.8989.018; Tue, 5 Aug 2025
 10:27:38 +0000
Message-ID: <b3f97ffd-2e25-4df6-9da5-65264ee6916b@nvidia.com>
Date: Tue, 5 Aug 2025 20:27:32 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 02/11] mm/thp: zone_device awareness in THP handling code
To: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>,
 Zi Yan <ziy@nvidia.com>
Cc: David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Karol Herbst <kherbst@redhat.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Barry Song <baohua@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Matthew Wilcox <willy@infradead.org>,
 Peter Xu <peterx@redhat.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Jane Chu <jane.chu@oracle.com>, Alistair Popple <apopple@nvidia.com>,
 Donet Tom <donettom@linux.ibm.com>, Matthew Brost <matthew.brost@intel.com>,
 Francois Dugast <francois.dugast@intel.com>,
 Ralph Campbell <rcampbell@nvidia.com>
References: <20250730092139.3890844-1-balbirs@nvidia.com>
 <11ee9c5e-3e74-4858-bf8d-94daf1530314@redhat.com>
 <b5fa0989-a64a-4c91-ac34-6fb29ee6d132@redhat.com>
 <EC99D49E-86FF-4A50-A1AA-FC43A7D3716C@nvidia.com>
 <14aeaecc-c394-41bf-ae30-24537eb299d9@nvidia.com>
 <e5dd3f46-c063-45ff-8be7-64ac92534985@redhat.com>
 <71c736e9-eb77-4e8e-bd6a-965a1bbcbaa8@nvidia.com>
 <edbe38d4-3489-4c83-80fb-dc96a7684294@redhat.com>
 <e8f867cf-67f1-413a-a775-835a32861164@nvidia.com>
 <ee06bd19-4831-493f-ae88-f1d8a2fe9fa4@redhat.com>
 <47BC6D8B-7A78-4F2F-9D16-07D6C88C3661@nvidia.com>
 <2406521e-f5be-474e-b653-e5ad38a1d7de@redhat.com>
 <A813C8B0-325E-44F0-8E30-3D0CBACB6BE1@nvidia.com>
 <ab46303e-a891-4f48-8a86-964155a1073d@nvidia.com>
 <920a4f98-a925-4bd6-ad2e-ae842f2f3d94@redhat.com>
 <f3e85850-bc5b-461a-9efc-d1961fb5d340@nvidia.com>
 <196f11f8-1661-40d2-b6b7-64958efd8b3b@redhat.com>
 <ede98867-bc17-4894-a375-d17d8f83dd55@nvidia.com>
 <087e40e6-3b3f-4a02-8270-7e6cfdb56a04@redhat.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <087e40e6-3b3f-4a02-8270-7e6cfdb56a04@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0167.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::22) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|SN7PR12MB8789:EE_
X-MS-Office365-Filtering-Correlation-Id: cce6c625-6ff5-4597-3e6c-08ddd40ab372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2dUTkZVaVdNT1Y2Kzhxd1Z0aWV6Um5iajRqUmFTcXF4clFKaXovVlNEems4?=
 =?utf-8?B?N2l0cENJNFlaR2s2Q2UyUDRuVkFLTjltMlRRU0V2eHluQ1JxSW9mNjFTZVNr?=
 =?utf-8?B?Sk1KaEtYSmM2N1FCZkc1NGoyZERvcXFFaEdoMnYrS215blZDQ0NjeVdKaHgw?=
 =?utf-8?B?YzV3ZXljZGtudjZYRjhWRDNPL3k1OHcya05sNU0wVytXZXFHLzdteUxrN1dY?=
 =?utf-8?B?NlVmRTZXemhCZzNGVFREcVNRdlZySitRRENYR1AxL0k2SUg1L2FEcGlvYWN0?=
 =?utf-8?B?ZVVwZVlLRUVjY1cxTGVxNjMwV25HWTUwVlVrYVVaak9BaHZKSkhMaXk2cnlp?=
 =?utf-8?B?TkdLdFhjb01tSms0Y056a1c2cm0wUzl5U01ZTUZacFFVSXNYaVlzYVM3bFZs?=
 =?utf-8?B?WnBpQS9RZmpWVzhQOEJzdFFtaWJVRFNya29Fd284UDcxRkRheUIyNHRybEZy?=
 =?utf-8?B?OWV4bGRnbFJ4NSttT0JrVHpUMWpFNGhJR3dBM2ljWGdhc0xGRHZlS1dKMzEv?=
 =?utf-8?B?ZEFFN1ViZHJoNFJkOXFqd2g4OWpuMG9TM3FyL1JWMnZ4UHFSak5iSkgvc0tp?=
 =?utf-8?B?c09VUXlCejltWTc3Q1Z3Q3J6TDlZa2VNRUptbVJnbGI2T0F0cjF3aUhpSkRE?=
 =?utf-8?B?WFRnMUl5bHlXVDZFcnBSWjAvR1ljY280ZGtxNDFPMmgwMmI3Q0c3OTB6ZmlL?=
 =?utf-8?B?cUpZRG93NzJWeWlsQ3BTL0N4cWxDMmgvYXY1MDlVYWJCdDdUUE81c2tXUzYw?=
 =?utf-8?B?L09yaWZraUhVam1ZTlhCbG8zQzdUVUVUYi90cnlyMEJtV1R5QzBOZVRkcUhI?=
 =?utf-8?B?TTIwZVFGelNzbEFtSHFEajJDbGFUWkRtOXBMUVBlckxXNXBhaGpLaWZsbGJU?=
 =?utf-8?B?WEtrTi9WMVErLzFTUVJzWEtjQzIrQU92c0NrOENKUlAvc0NZNDRkalBsUXJn?=
 =?utf-8?B?Qk43RkdtbTBrR2dOTndDZGJhSXZQUDlJYUxJQTdSK3Q4SHF1OGJiUFFFWWY1?=
 =?utf-8?B?OUg1Y0VwN3E4RVd6RlhiTGFTbGNWcWpzL21yQnk5KzNFQVR3Q0Z4amVNV3J4?=
 =?utf-8?B?QnFsWTNzcDdoS1M1MFF0UHBScnY3MEFZY095WXRXNXhiMkdkT25rMXhEdEdx?=
 =?utf-8?B?Z0NhaXlUakhOS2MySHFUQllRNVFQWTRtZFhaVC9Ha2JGeDhvL3lrcFMvZFFI?=
 =?utf-8?B?SUlCbi9lM2J5d1doUk9Vd3IzRWpTVFpIYTAwVy8rbU0ySTVJaXAxRUFTc0VV?=
 =?utf-8?B?RDJ4aGZyZ0w5ejZrUStwQVF4WHhJaWMvQkthT1pzWVY2S2ZKMEtmdVFPMWE4?=
 =?utf-8?B?d01SeThvVDFhdDZhNzYzb3NvTHFOa292M2UxRk5PSmNDRGtkTUxHVGEzL1ly?=
 =?utf-8?B?Y0Vmd2hlT29uVDllbC94VW9nU1pBRWdsWWVXNkU5ZDJNRlJrRG9NbXIyUHN5?=
 =?utf-8?B?QnNnSXdiTWU0bVlIRERQenlHb1FlcC83UE5odVFnOVorN2hYb05ScWpza3hl?=
 =?utf-8?B?MzZtVGlaSDAyaStDTXdyS09kKzU5Sk9PQ3JER0FsaXFpOG56cllrUnlmNE5k?=
 =?utf-8?B?N0FIbzEyVjBqamRDdnZna1RSSi9DTHBJZ1ovSC9QL0JHVE1TMUt5dDZFZXNh?=
 =?utf-8?B?TXJOaHdBMkdOdEZic2JYaTREdXltOThVd05pQldGUTJlQXpmeGRzZ2thMnNq?=
 =?utf-8?B?UGxuam0zNjM0a0Z4eFk3MTBWUUUya2kzWG14VjlDaXdyWlpGdENHWWM3RlBS?=
 =?utf-8?B?WjF3R29taTFwNzZlUm52VkZKVmdvSCtsOW4rZC92V2xob1J5SjlLaW84NjBN?=
 =?utf-8?B?NEp1OUNoTmlhbUNvRDA1aGRkTUw5S1dkVk9qaFpjclgrVzkzN296MVRvd1Jn?=
 =?utf-8?B?T3JmN0JiR2tFUXNQYjNUL0JmUFpEREc4ZTVmNkdIclVVSVNKVDArL0lQM2lV?=
 =?utf-8?Q?xgTLvCFKP8I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cVJWUThDc0diaU1QS25xdkYzVFN3ZmdERFEra0hVcmdCT0pDZVFKai9EakRJ?=
 =?utf-8?B?T24zOUh2d1lRR1VuK1FMS0k1WUpKMFJUR0dOQXdNRGYydnEzRUVyK0QzYURu?=
 =?utf-8?B?OFNlS2pUNmh1MVorZG1QMmZmb2VhRjNTdXNxZENWMmVSM3BsRVpmemRhcVFS?=
 =?utf-8?B?U1QwMHZMMFlPeFN0cTlBNmtHNkM0MTNVdmNkVUtkMDVRWW8rWmJYdVNMWENU?=
 =?utf-8?B?NE1rT3M3QTdGekR0SzV2UVZPYjNJT3ZoWndFSkk5dGQyNEFsc08rLzRKRDg1?=
 =?utf-8?B?QWo4dktOVWx6dFd3OW02YkRRaWlQYnRHWVQ0UTRLc0xuWTVKVStyVWh3L3lX?=
 =?utf-8?B?OVFpU2pRVjVQa3FDcTVWd3RtcmxGWmExaXBxTFV0elpEeVFIMWNaeGpPRnZ4?=
 =?utf-8?B?ZmhuS2RiZ0ZCUnRlQnhrdDZpMTVpTmliU0hsOThtUFQxVXR6Qmx1eDUvdTlW?=
 =?utf-8?B?aXpyWXlLOEExZGpvOXo0U0p0RG1sb1U5MEVLM0tDSGIyaGFFM1Z6Y1VXUEpW?=
 =?utf-8?B?ZXhCRzJ4TDNPZW0xWDhzRXhTc2FuOXM3RXNXbmNCRm9saFQvelZHazBBRTZU?=
 =?utf-8?B?OHpuZmt3VXFlV2pRUmFxTjYxZWR6Q2E5VzFIdUZ0U080U0NmblZzMEN5RExQ?=
 =?utf-8?B?UFRTUjROMlNhdXpGakVWNFY1SzIwa1gwNWVkM1hiWW9xOEgvYzBPS3pUYkxx?=
 =?utf-8?B?ZjVjTlFJRjlkVUM0M05ST3RQNGJqZjVGenM3VVFmeUVxSzJjaEdrSGh0NTdD?=
 =?utf-8?B?cndTQUxJUnQrMTVOYzhjK2hyN0ZlcDN3RFpzRVdNUldrdlhUY3NQRDVpRWoz?=
 =?utf-8?B?b0FXMStkOC9DTWNMaVliUE4vS0xmSHlRYzk1ZUpDL2dHRDR4dlFxYXErSklJ?=
 =?utf-8?B?TDE1T24rN0tmMTZ6TzlHbU1jQ3NWa2dRa0hmWGVDZmhpOU14dGZLN25TaGhm?=
 =?utf-8?B?OTdDbHVWWisvdkVFcXFhc3ZReTBUNElnSk9jTEhmeTZVSFFteGJDSmJuck56?=
 =?utf-8?B?bFFEckdvYktvdEszNTI0WkhXb3R1TGtmaVhQa3hCVG0yaXRxaW1hK1duQncr?=
 =?utf-8?B?MFpxN05ibG4zQ201ZlZ1eEhTZDVtOFFvNWRCMlBhcjlrMnlGY0dpakdwbkpW?=
 =?utf-8?B?VmtKYjI1Q0lNcW5FbU5MVDVWZUw2blRPN09pZEtTTnRiaHZiZDNiVWtKZGFi?=
 =?utf-8?B?U1lZa0dKZFR4TlRUSndodno2R0JxWEU4SEtINW92WVdCQ25CMk45cEV5aWNU?=
 =?utf-8?B?bk9kZThlaVNhRTdxeVFvK29LS2ZGcGt6Rks0QVlvaUFGUTBIZ20xdzdzeUFU?=
 =?utf-8?B?VW5jbVgycHVaZjUyREw3Nm0xUnRjOFBNWGR4aUp2SFM4WnpKUnFIWVJ0SHRL?=
 =?utf-8?B?YVdQOUZPUkRSczdKeVJOMVkzYjVobFpzMkJ6YitQbVI1d2YzZW5GcHlGS1NT?=
 =?utf-8?B?aDIxNHVVV0RDNHpSL2llZUU0SUlIYW5RQkYwN0t6ZlNxK0RPd0ZYcWptQkdI?=
 =?utf-8?B?OHl3dERrOTU1Z2FMVVFpUkE0bTVIbnZyOEFtL3YzRzVjek9RNG9qTXlkazRu?=
 =?utf-8?B?ZzRUVGxLdThIMUlFc0tnMUV5VTlNWGx6dXhkQk90ckZ1K0RXaytCV1htOHg4?=
 =?utf-8?B?akZ1VUt1VEpyaEVELzlvQi82bzk0Y1o3aDRDVUZJclFUaXlJT3cvYWg1OE5N?=
 =?utf-8?B?TlJyazdGY29HVG1jaSt5RlVXRFUvQTNZV0Vhb3o0WTFOZVRNbGVsMlBsMEhY?=
 =?utf-8?B?R1NpRmd0TWROcm5pVUJxbkZ6eTdWTzJiRmU0Um54RFh6bGRNUVI1NmZXVGNx?=
 =?utf-8?B?UHRnYmZPVjRQSFdRSXllUWhNU3VMYndLNzEwYzd2TGVUYWxYV0MzQ0VaSGFM?=
 =?utf-8?B?UW1YNGR3NDk5eS9XYjZqcDBVcDVhQ3hqNDBQT0I3Mnl1d3VaNFdQSGFTSUFS?=
 =?utf-8?B?QXlBRGhlcDQrWno4Z2NIZDNRbTd0djBhbGpjVEplQVdHOE1zVUMyekQ1Nisv?=
 =?utf-8?B?SU5BQ2MxbWorek9pNnpReUd4elpUL1IraGgxWHFjK2xqOU00V1paelQ4VmFF?=
 =?utf-8?B?LzFUZmJRc1h6bzc5N29yVk9aWUJzUW1XdDY4eXNOcVlkOEg4QlUrSzQyTkE4?=
 =?utf-8?Q?Ty3SxroCknIs4ks8eFF7555Yj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce6c625-6ff5-4597-3e6c-08ddd40ab372
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 10:27:38.5295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wu1SGQE/hJ+ZfJBXXJk5GYVsXk8oJ4caEt+wzUbQj9BhyHaaK9SB160S5YbE1VNeu3rrRZDUhgc5ABoNUhNWfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8789

On 8/5/25 14:24, Mika Penttilä wrote:
> Hi,
> 
> On 8/5/25 07:10, Balbir Singh wrote:
>> On 8/5/25 09:26, Mika Penttilä wrote:
>>> Hi,
>>>
>>> On 8/5/25 01:46, Balbir Singh wrote:
>>>> On 8/2/25 22:13, Mika Penttilä wrote:
>>>>> Hi,
>>>>>
>>>>> On 8/2/25 13:37, Balbir Singh wrote:
>>>>>> FYI:
>>>>>>
>>>>>> I have the following patch on top of my series that seems to make it work
>>>>>> without requiring the helper to split device private folios
>>>>>>
>>>>> I think this looks much better!
>>>>>
>>>> Thanks!
>>>>
>>>>>> Signed-off-by: Balbir Singh <balbirs@nvidia.com>
>>>>>> ---
>>>>>>  include/linux/huge_mm.h |  1 -
>>>>>>  lib/test_hmm.c          | 11 +++++-
>>>>>>  mm/huge_memory.c        | 76 ++++-------------------------------------
>>>>>>  mm/migrate_device.c     | 51 +++++++++++++++++++++++++++
>>>>>>  4 files changed, 67 insertions(+), 72 deletions(-)
>>>>>>
>>>>>> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
>>>>>> index 19e7e3b7c2b7..52d8b435950b 100644
>>>>>> --- a/include/linux/huge_mm.h
>>>>>> +++ b/include/linux/huge_mm.h
>>>>>> @@ -343,7 +343,6 @@ unsigned long thp_get_unmapped_area_vmflags(struct file *filp, unsigned long add
>>>>>>  		vm_flags_t vm_flags);
>>>>>>  
>>>>>>  bool can_split_folio(struct folio *folio, int caller_pins, int *pextra_pins);
>>>>>> -int split_device_private_folio(struct folio *folio);
>>>>>>  int __split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
>>>>>>  		unsigned int new_order, bool unmapped);
>>>>>>  int min_order_for_split(struct folio *folio);
>>>>>> diff --git a/lib/test_hmm.c b/lib/test_hmm.c
>>>>>> index 341ae2af44ec..444477785882 100644
>>>>>> --- a/lib/test_hmm.c
>>>>>> +++ b/lib/test_hmm.c
>>>>>> @@ -1625,13 +1625,22 @@ static vm_fault_t dmirror_devmem_fault(struct vm_fault *vmf)
>>>>>>  	 * the mirror but here we use it to hold the page for the simulated
>>>>>>  	 * device memory and that page holds the pointer to the mirror.
>>>>>>  	 */
>>>>>> -	rpage = vmf->page->zone_device_data;
>>>>>> +	rpage = folio_page(page_folio(vmf->page), 0)->zone_device_data;
>>>>>>  	dmirror = rpage->zone_device_data;
>>>>>>  
>>>>>>  	/* FIXME demonstrate how we can adjust migrate range */
>>>>>>  	order = folio_order(page_folio(vmf->page));
>>>>>>  	nr = 1 << order;
>>>>>>  
>>>>>> +	/*
>>>>>> +	 * When folios are partially mapped, we can't rely on the folio
>>>>>> +	 * order of vmf->page as the folio might not be fully split yet
>>>>>> +	 */
>>>>>> +	if (vmf->pte) {
>>>>>> +		order = 0;
>>>>>> +		nr = 1;
>>>>>> +	}
>>>>>> +
>>>>>>  	/*
>>>>>>  	 * Consider a per-cpu cache of src and dst pfns, but with
>>>>>>  	 * large number of cpus that might not scale well.
>>>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>>>> index 1fc1efa219c8..863393dec1f1 100644
>>>>>> --- a/mm/huge_memory.c
>>>>>> +++ b/mm/huge_memory.c
>>>>>> @@ -72,10 +72,6 @@ static unsigned long deferred_split_count(struct shrinker *shrink,
>>>>>>  					  struct shrink_control *sc);
>>>>>>  static unsigned long deferred_split_scan(struct shrinker *shrink,
>>>>>>  					 struct shrink_control *sc);
>>>>>> -static int __split_unmapped_folio(struct folio *folio, int new_order,
>>>>>> -		struct page *split_at, struct xa_state *xas,
>>>>>> -		struct address_space *mapping, bool uniform_split);
>>>>>> -
>>>>>>  static bool split_underused_thp = true;
>>>>>>  
>>>>>>  static atomic_t huge_zero_refcount;
>>>>>> @@ -2924,51 +2920,6 @@ static void __split_huge_zero_page_pmd(struct vm_area_struct *vma,
>>>>>>  	pmd_populate(mm, pmd, pgtable);
>>>>>>  }
>>>>>>  
>>>>>> -/**
>>>>>> - * split_huge_device_private_folio - split a huge device private folio into
>>>>>> - * smaller pages (of order 0), currently used by migrate_device logic to
>>>>>> - * split folios for pages that are partially mapped
>>>>>> - *
>>>>>> - * @folio: the folio to split
>>>>>> - *
>>>>>> - * The caller has to hold the folio_lock and a reference via folio_get
>>>>>> - */
>>>>>> -int split_device_private_folio(struct folio *folio)
>>>>>> -{
>>>>>> -	struct folio *end_folio = folio_next(folio);
>>>>>> -	struct folio *new_folio;
>>>>>> -	int ret = 0;
>>>>>> -
>>>>>> -	/*
>>>>>> -	 * Split the folio now. In the case of device
>>>>>> -	 * private pages, this path is executed when
>>>>>> -	 * the pmd is split and since freeze is not true
>>>>>> -	 * it is likely the folio will be deferred_split.
>>>>>> -	 *
>>>>>> -	 * With device private pages, deferred splits of
>>>>>> -	 * folios should be handled here to prevent partial
>>>>>> -	 * unmaps from causing issues later on in migration
>>>>>> -	 * and fault handling flows.
>>>>>> -	 */
>>>>>> -	folio_ref_freeze(folio, 1 + folio_expected_ref_count(folio));
>>>>>> -	ret = __split_unmapped_folio(folio, 0, &folio->page, NULL, NULL, true);
>>>>>> -	VM_WARN_ON(ret);
>>>>>> -	for (new_folio = folio_next(folio); new_folio != end_folio;
>>>>>> -					new_folio = folio_next(new_folio)) {
>>>>>> -		zone_device_private_split_cb(folio, new_folio);
>>>>>> -		folio_ref_unfreeze(new_folio, 1 + folio_expected_ref_count(
>>>>>> -								new_folio));
>>>>>> -	}
>>>>>> -
>>>>>> -	/*
>>>>>> -	 * Mark the end of the folio split for device private THP
>>>>>> -	 * split
>>>>>> -	 */
>>>>>> -	zone_device_private_split_cb(folio, NULL);
>>>>>> -	folio_ref_unfreeze(folio, 1 + folio_expected_ref_count(folio));
>>>>>> -	return ret;
>>>>>> -}
>>>>>> -
>>>>>>  static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>>>>>>  		unsigned long haddr, bool freeze)
>>>>>>  {
>>>>>> @@ -3064,30 +3015,15 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
>>>>>>  				freeze = false;
>>>>>>  			if (!freeze) {
>>>>>>  				rmap_t rmap_flags = RMAP_NONE;
>>>>>> -				unsigned long addr = haddr;
>>>>>> -				struct folio *new_folio;
>>>>>> -				struct folio *end_folio = folio_next(folio);
>>>>>>  
>>>>>>  				if (anon_exclusive)
>>>>>>  					rmap_flags |= RMAP_EXCLUSIVE;
>>>>>>  
>>>>>> -				folio_lock(folio);
>>>>>> -				folio_get(folio);
>>>>>> -
>>>>>> -				split_device_private_folio(folio);
>>>>>> -
>>>>>> -				for (new_folio = folio_next(folio);
>>>>>> -					new_folio != end_folio;
>>>>>> -					new_folio = folio_next(new_folio)) {
>>>>>> -					addr += PAGE_SIZE;
>>>>>> -					folio_unlock(new_folio);
>>>>>> -					folio_add_anon_rmap_ptes(new_folio,
>>>>>> -						&new_folio->page, 1,
>>>>>> -						vma, addr, rmap_flags);
>>>>>> -				}
>>>>>> -				folio_unlock(folio);
>>>>>> -				folio_add_anon_rmap_ptes(folio, &folio->page,
>>>>>> -						1, vma, haddr, rmap_flags);
>>>>>> +				folio_ref_add(folio, HPAGE_PMD_NR - 1);
>>>>>> +				if (anon_exclusive)
>>>>>> +					rmap_flags |= RMAP_EXCLUSIVE;
>>>>>> +				folio_add_anon_rmap_ptes(folio, page, HPAGE_PMD_NR,
>>>>>> +						 vma, haddr, rmap_flags);
>>>>>>  			}
>>>>>>  		}
>>>>>>  
>>>>>> @@ -4065,7 +4001,7 @@ static int __folio_split(struct folio *folio, unsigned int new_order,
>>>>>>  	if (nr_shmem_dropped)
>>>>>>  		shmem_uncharge(mapping->host, nr_shmem_dropped);
>>>>>>  
>>>>>> -	if (!ret && is_anon)
>>>>>> +	if (!ret && is_anon && !folio_is_device_private(folio))
>>>>>>  		remap_flags = RMP_USE_SHARED_ZEROPAGE;
>>>>>>  
>>>>>>  	remap_page(folio, 1 << order, remap_flags);
>>>>>> diff --git a/mm/migrate_device.c b/mm/migrate_device.c
>>>>>> index 49962ea19109..4264c0290d08 100644
>>>>>> --- a/mm/migrate_device.c
>>>>>> +++ b/mm/migrate_device.c
>>>>>> @@ -248,6 +248,8 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>>>>>>  			 * page table entry. Other special swap entries are not
>>>>>>  			 * migratable, and we ignore regular swapped page.
>>>>>>  			 */
>>>>>> +			struct folio *folio;
>>>>>> +
>>>>>>  			entry = pte_to_swp_entry(pte);
>>>>>>  			if (!is_device_private_entry(entry))
>>>>>>  				goto next;
>>>>>> @@ -259,6 +261,55 @@ static int migrate_vma_collect_pmd(pmd_t *pmdp,
>>>>>>  			    pgmap->owner != migrate->pgmap_owner)
>>>>>>  				goto next;
>>>>>>  
>>>>>> +			folio = page_folio(page);
>>>>>> +			if (folio_test_large(folio)) {
>>>>>> +				struct folio *new_folio;
>>>>>> +				struct folio *new_fault_folio;
>>>>>> +
>>>>>> +				/*
>>>>>> +				 * The reason for finding pmd present with a
>>>>>> +				 * device private pte and a large folio for the
>>>>>> +				 * pte is partial unmaps. Split the folio now
>>>>>> +				 * for the migration to be handled correctly
>>>>>> +				 */
>>>>>> +				pte_unmap_unlock(ptep, ptl);
>>>>>> +
>>>>>> +				folio_get(folio);
>>>>>> +				if (folio != fault_folio)
>>>>>> +					folio_lock(folio);
>>>>>> +				if (split_folio(folio)) {
>>>>>> +					if (folio != fault_folio)
>>>>>> +						folio_unlock(folio);
>>>>>> +					ptep = pte_offset_map_lock(mm, pmdp, addr, &ptl);
>>>>>> +					goto next;
>>>>>> +				}
>>>>>> +
>>>>> The nouveau migrate_to_ram handler needs adjustment also if split happens.
>>>>>
>>>> test_hmm needs adjustment because of the way the backup folios are setup.
>>> nouveau should check the folio order after the possible split happens.
>>>
>> You mean the folio_split callback?
> 
> no, nouveau_dmem_migrate_to_ram():
> ..
>         sfolio = page_folio(vmf->page);
>         order = folio_order(sfolio);
> ...
>         migrate_vma_setup()
> ..
> if sfolio is split order still reflects the pre-split order
> 

Will fix, good catch!

>>
>>>>>> +				/*
>>>>>> +				 * After the split, get back the extra reference
>>>>>> +				 * on the fault_page, this reference is checked during
>>>>>> +				 * folio_migrate_mapping()
>>>>>> +				 */
>>>>>> +				if (migrate->fault_page) {
>>>>>> +					new_fault_folio = page_folio(migrate->fault_page);
>>>>>> +					folio_get(new_fault_folio);
>>>>>> +				}
>>>>>> +
>>>>>> +				new_folio = page_folio(page);
>>>>>> +				pfn = page_to_pfn(page);
>>>>>> +
>>>>>> +				/*
>>>>>> +				 * Ensure the lock is held on the correct
>>>>>> +				 * folio after the split
>>>>>> +				 */
>>>>>> +				if (folio != new_folio) {
>>>>>> +					folio_unlock(folio);
>>>>>> +					folio_lock(new_folio);
>>>>>> +				}
>>>>> Maybe careful not to unlock fault_page ?
>>>>>
>>>> split_page will unlock everything but the original folio, the code takes the lock
>>>> on the folio corresponding to the new folio
>>> I mean do_swap_page() unlocks folio of fault_page and expects it to remain locked.
>>>
>> Not sure I follow what you're trying to elaborate on here
> 
> do_swap_page:
> ..
>         if (trylock_page(vmf->page)) {
>                 ret = pgmap->ops->migrate_to_ram(vmf);
>                                <- vmf->page should be locked here even after split
>                 unlock_page(vmf->page);
> 

Yep, the split will unlock all tail folios, leaving the just head folio locked
and this the change, the lock we need to hold is the folio lock associated with
fault_page, pte entry and not unlock when the cause is a fault. The code seems
to do the right thing there, let me double check

Balbir
and the code does the right thing there.

