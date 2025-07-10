Return-Path: <linux-kernel+bounces-725749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C026CB00340
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 15:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D729C1C45836
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 13:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460B822A1C5;
	Thu, 10 Jul 2025 13:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="fXwqCflq"
Received: from CAN01-YQB-obe.outbound.protection.outlook.com (mail-yqbcan01on2104.outbound.protection.outlook.com [40.107.116.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE12E2253AE
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 13:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.116.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752153799; cv=fail; b=Rb0V/8hoExDGv5ADH+wlNPbbAP433LTB04KI2ggjNUHuxAqRtjMo0hxBJivX9fIjTR3EqyHo3DndM9KRnms62If0q+q5jO1n3VyKSBc2Kp7HaC0gzc6rYbh9HxvuvNpRIHGbwPolt9w8zwixAokAoe9uQxAQdFcGEZqorDO6Ufg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752153799; c=relaxed/simple;
	bh=HUxoE9RhHLnDVKIS8vjaaTwtfP7mAt3OOk97TDQy8pI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IPO8otxg1PwtDRV+uSrwzLJHHhSwWO3Hh/jfLKG8ZrsbGcu9tu/V/pVdUtcxgKgGlUj+U+3onzYPjU9eEq/WC0eCNyYlc3jxaWzYuTpo/LAeYm8j+V1ZPqPjk1I6SRsn6uOHkY6WzLEdYhpXQhBAKFV3cR86d5j4OOU0gxM+rn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=fXwqCflq; arc=fail smtp.client-ip=40.107.116.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GtloUe8ggtoPw9OuVIyZzQTIo2KP2Wia6LcfXDIkkBb/QAIOKn819qRmfnFMDHljKsTzis/iqse6oJwONMOXWrSGHe9D8VN2R/IvI7J3JBfEPn60DISX73oVKvHcOCMFAgifkBsbqEAXxgUBdA4jLiyoj9xj3Z8/cri3sBCv0S/tlmJ0ThbAMTZPXyAqe9VnVSBLR3cFuBl7kDaFfjZplwZP8YM5Yz0D0VBvjLJCo7k4vHX2o0TgAXSrPNQxW3XL/3Yvy/0XfnmstU6Sd0QczXo4+Rv7EVEZhtClYwuy2hJ8HF83gTyrdWuKYW8IKgit0brWOZY8S3rQMICWnJjnZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y600oBuXYNWy0oEPotb7GsasxkvRDqUnBdWqCaQzJ8M=;
 b=a89Y+F2vkT1EGt2IDDCyRQyjO6FofwEvRKPA9kY9Bs6eDo75IOZXKYnccg/08bfa9KYF3qCYEjAjFNmPNSirbt8Rx3pYsHSvgrOFufKos6caddZZrDMwuMH7z4dgQkJhkZ79/MyHq3lUs/FkMIVWhkkMYot8rhFIFpphzFuU4CEHjWr2MUAEkcTcEt7sy1Bnh5uj5/RRz7mCGVBLj3xOSsFTtYE3InxTBNh3ItTxUmzhkA0x4oneFGY7uHhq51YPqLO0HpgBfVgQA27C8U1aLEXkoVhbM+ylNfkm566JmDggEaf4DK202F+OYRhyI6p/sIKqnoKd2HFay2tiu/gsrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y600oBuXYNWy0oEPotb7GsasxkvRDqUnBdWqCaQzJ8M=;
 b=fXwqCflqWxUQ3IVYjqaNGg8uhAOK8e3JZWccv0jkzYj3Oj6uD2hA3FLBWLWzXdkxctxcidWZ96naV8A7NZkUapOaTs+6BqgNKMeBWYOtGplVqFkk6yiswZSEoMqROGK1kyr7PqgozugfO4t+Q/pcK7bBap21SK1XYm79dlXusl1V3tR9/xosmcM3N3oFHORcB1XsJlM7HJfW/a7OTOkg0BRXPiMDj/xbwxy/H+O6Y+ufSpv9GIY2c3uCn3RdoUTWxlNNkI05kFwDv0NwkPjHyB72vDxJhxhuwysCeFeJ1mzlVLZ0R9+Unuky+PFO5SYxUUcsX2yZT877fYIs5PgaQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT1PR01MB9276.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:ab::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Thu, 10 Jul
 2025 13:23:12 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 13:23:12 +0000
Message-ID: <d8eacb24-af73-4580-8248-1fd1ac33e28f@efficios.com>
Date: Thu, 10 Jul 2025 09:23:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 2/3] sched: Move task_mm_cid_work to mm timer
To: kernel test robot <oliver.sang@intel.com>,
 Gabriele Monaco <gmonaco@redhat.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, aubrey.li@linux.intel.com,
 yu.c.chen@intel.com, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Ingo Molnar <mingo@redhat.org>
References: <202507100606.90787fe6-lkp@intel.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <202507100606.90787fe6-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0103.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:83::12) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT1PR01MB9276:EE_
X-MS-Office365-Filtering-Correlation-Id: 2226a31b-1093-4623-c2d1-08ddbfb4eb62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b05CY3dxRUJIVEpxVmRLOG1LMmZPbkxwQ3lhd1B1eTE2aHFGWmxVb2hGU3ps?=
 =?utf-8?B?VC90UWttLy9seU41a3psQ1l3NUJPU2R3Qkk5UmxWdmllQVlENTdTVFBoWkNX?=
 =?utf-8?B?WENEWmdhekFNckdoTUhRK0hmMWM2ZDNndW9RV1RRaXlWQlRZWklEejNUK04y?=
 =?utf-8?B?YlNINEduemJ2TTA2elBnZm0rcXN6eE9ST0NVVE1kRmV3NXZJUndWYTlNU0RO?=
 =?utf-8?B?blJRai8xdUVQZ2x4SnlZUGNZc1h5UG1vbFgwNUZ3cTNWdWhIcWhvNkJrYVR2?=
 =?utf-8?B?dDVobnFhTmhGMVU0c1NLWmt6SG1GVWlBald2SEJwbDZ5WWVVVFEwV3FFSDdx?=
 =?utf-8?B?TElqbnNPVXQ3NWg3bjBhSnNWQmlvNWZ6aCtvdmFBYkZ1dDBlU0pWWVFjTHRK?=
 =?utf-8?B?NHJOSExjVm92Mm9ONk15UitsMzVyOXAwRlJuOFp1NHBtSDhQZkxXZkx6M1lK?=
 =?utf-8?B?UnRFeXZjbDlyRjJXVVBUM3EyNFhRUkZ0dng4NnZ2TUNXU0psQ1ViL0REZ0tr?=
 =?utf-8?B?T3RSRmxlaGJETzQvWUd6bStoQTYzVzdKb2VOUkhVUE9idnVLL1cvaUQxcE5R?=
 =?utf-8?B?ZWU5d2NrNExFZmVpV0YrMW5qRmxRYTBrUWxGVTlSQTFNd3FFU2p6Q0VuaWJ0?=
 =?utf-8?B?Y2U5Q3V3SnpDZGVWK3BycVg3dDQ4UDVReXUxUW9POVlQektiSWVpSzRBQy9i?=
 =?utf-8?B?M3c0aEdRT3ZzSCtwL0c4c0k0ckZjUjhpY3NWMEZaOFg4NGxUWFFMc2FmU0pB?=
 =?utf-8?B?T2EwSGpLQ1FFTTk5Z3Z2Y2xUUDVySWxQNHVFanl4bWJsT0FXVU9WS203UGRu?=
 =?utf-8?B?T3VZbmdoNkE1dk1NdVZnbGxsWEtzT3U4SnRFZzF1QjgzTXVzQ3RvWXliL3h4?=
 =?utf-8?B?Nmd0THovejBrNUFnd2FFTjZ0UXNyeGRmMWxZU3ZPdXdBMTBRYXJxaU5CWi8x?=
 =?utf-8?B?YVFFUUFsVHRRVHVqMXlmbHhtdU44VmZDR3V3OUtjV1FsN2MwQU1WYmViZk9a?=
 =?utf-8?B?Q1JHQWJONnNUeUFDbTE3cEFTRjVBZEZqRlRuWmxwRmhQOVFhc25PdHRRRElT?=
 =?utf-8?B?UXlad2Z3MkUwU0hWVFg2TUJUcGxuOWM3cFpSMWxjejAyTXpRRmQram5ETUtQ?=
 =?utf-8?B?Y01QcGRuT2tlQWtrdG54MHJRUU9CdjlNQkFKWnRyQWZNT3BObnJQdW5sYkd6?=
 =?utf-8?B?TXJJV2FraGZqQk5WeTk2THU0SFkzdlRlTU1VUmtkVXNyNStaeU01dEVxQWdm?=
 =?utf-8?B?VWhndmNBYXFHUEk1cHJkTVJQK2J3dDRlOG9YQmUyaHNQZENlSGFLcWVhMWN1?=
 =?utf-8?B?d3FyekNTWis0RWwrUStWL2xzOEpjdU1mWGhNRkIrY1FONVBUcXozMENPMlVp?=
 =?utf-8?B?MlIwSmc5Q3ZMVHR2SHpsbk81bnFJbjJyQUtzQlFNRDJzaVUwUzVYUUhiVllq?=
 =?utf-8?B?MmZSdmliaFBwYXAvN0pkcW41Ym9IZWRxdnBrQUFrU1krNVk1ZDVuVjBlR1Qv?=
 =?utf-8?B?UkVxSFFnV0VBMG9lQ1ltU2dXQUE1dFZwWVMxa3N0RUoxVjJZd3R6dHBJVE5r?=
 =?utf-8?B?dmRISjdpR2xiREplZ1BOVkh3M0Z2dkRsZXRwcWtkc216TVY3Qk1pbGMvZm9O?=
 =?utf-8?B?aVhZSmNBOVgxRzlXTno5anR5RXYvQ3c1TDVaZTFUYlRBRTRHa2RXNU16UE50?=
 =?utf-8?B?S1Mrc05lT0NSUVNtZ0t4ZXFhZ0tEclJUdnpVeXRUOTNMdHJxaVdaQlk2Z2Zo?=
 =?utf-8?B?REJjZlhOeno0SDJILzNZSnkvNGsxWTNjSDgyUWdMMXZBRDdubGJlbitXRnZK?=
 =?utf-8?Q?gsbpWNzn0uhdzewicnHRRl6MVujxUkrpLjInk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDFjM1docE1FODFJZmlnS3RiNVhIaUJLTXpiZkJJaWxRbmlmN3gzU3NpV2RV?=
 =?utf-8?B?Sk8vdk5QSzBVcmRST0tnclJGZG0wNHNPOXdleCt1WDY3Qnd4YW0rcWg3T1hC?=
 =?utf-8?B?bDByUWNqWVJDbitueHhJQmdId0lCeWl2K1pPTTJ6T3JoL3YzSW1SNUJPR3Nr?=
 =?utf-8?B?NjNWd3dYWXozYmQvWjVLbEdUVTRqNTJMK25pNnFoMlBFRURCUUwwQnZhMnBw?=
 =?utf-8?B?Mis2dnhndXJYQlVkejRXVmZUWE9OZDB4U3B3R3JPeXd4TmFLZjlITzdENU9Z?=
 =?utf-8?B?eGdEMTVyUXFFN0hJcHhsVFZIMUE0U0VDT2NuTzYvS3E5bFJBaXZId0xqc216?=
 =?utf-8?B?bkNtK2psRFc3T2NaWkRHNWtuekErNmZOSElVN3NERzdaMjh0MzEwbThHdkZ6?=
 =?utf-8?B?dnBUNzZoWlJ2NWphSGpsRjhGQkZ0WnV5RXhXdUc4ci9McXd5SWUxVGd5Ukxz?=
 =?utf-8?B?Z3dVL0ZGM0RHNnZqN00ybFRWVVg2bGVXbXNXandtUHVzQlI2Q1VVOUUreVUy?=
 =?utf-8?B?RTdBdDRyWEtmbmoyeWNKU1UzY05BVW5Sci80OEJiRllyR3FlQ1htNVJxY0pu?=
 =?utf-8?B?dXEwOUszc2xHdnRhUG5UYmtWWGRxK3NrZzUrZFhVT09NRjdiTHRSUnFCcTJB?=
 =?utf-8?B?RHQ4M0RRSmVzMFNCclFEUGdKeERZM2loeUhHaWhXNSt3WVNEVFhIcEpRVmwx?=
 =?utf-8?B?RCtaWVNwMWpPaVFURDJ0WCtoTm9iNUIrSERBWHhkOXJ4U0RrNnkrTFgwU2tY?=
 =?utf-8?B?TmFOSmgyZURwSjU5a3ZNR0VLYkp5WE5sbnpqZkE5NXA4U2tOOE40bVhUeFJI?=
 =?utf-8?B?U01zdGEzMllub3BSRTZpUWJxK1JJa3lXQnhrUGJjZVVlbTFoTktrbDNDU2Zr?=
 =?utf-8?B?MGNVZHM0Z0tGYjNhS1pWaFVMY0pjMURNaHBvYlU1WTkvQjRXLzZoWGZjdTcr?=
 =?utf-8?B?cWdxNjdEUUl6MEZKS3JnYmFaNWw3dVZ1OVdVQ2tzQzllelNkYUIzV3ByNlBq?=
 =?utf-8?B?eUNhdDNHMHhCTDFkcVhxQ3QwaE84T1psNUpGSHdDaVE3bWh4VVBjRjlCMzFq?=
 =?utf-8?B?aTVrK3hFQ293OTd2Qng2aUJtT2g5WSsrSnQyRWV3Rno1R3JGYmU1T29KUEFT?=
 =?utf-8?B?VmFvSUJkMlAveWhTd21YR2JaVjVtc0pHRkxzUDg1cWVhMitTbWtTSUhpU05i?=
 =?utf-8?B?VFlRNDMzUXVLK3RMbU96Y3VjNVRXOUpya0N2amlBTW45Q2RIQWhuZjlkS0tk?=
 =?utf-8?B?OFFjek5xUkQ3Q1J6STZVSjBFQUVTWFlSNWgreUdjRVZSYklsbGtxNlN0NWp4?=
 =?utf-8?B?MHh0bWJZSlBYU3AvQVZNMWpRZXEzckdya2R0YnF4RmdFOVZEY3F5bExGZmNX?=
 =?utf-8?B?WDVvejJoMngyekVXdUo3NzlYa25RWlpyUElQbDF5NHBOUGI0Rm8rK1QzQndU?=
 =?utf-8?B?ZGVUQUVya1BYZlRwUEhqLzZCUStwcm9GQVJCNmJnMGZ5M1ZWTGkrKzI2RFVv?=
 =?utf-8?B?cHBmbUhWWkpsaGVHT2x1elNieEtRb1czKzloc0VWME1vRDlBa2xmdmpHNzVw?=
 =?utf-8?B?WjBsd0hEWVZIclVLeElIRUV2S0MxWGxJaXZkMjJyVFNhRkNSc1NCWkhMSHZN?=
 =?utf-8?B?a2F4eGFRR3huNW9LOEJGbDR6T3NtODRiRG5tTE5WRkk2ZDVnVzJYMjZSSVky?=
 =?utf-8?B?LzJ0T2RsdXRFRDY2azVFU0hvcXZRU3lVK0xTUnFVMHhDS1dnMjFaVGs5Ymcz?=
 =?utf-8?B?bkt0bHVQRGdLL09NdDh2eGRUSnJkKzVNZEwxemd6cGl4N29QZ3R3MUtlTXdn?=
 =?utf-8?B?dldGTmNMY3Y5UU04Mzh5Ykh2Zjg1U293UVNFendxMkhxdmwyWnhUUXZ6TWtR?=
 =?utf-8?B?d3dramU4T2NpVzUrUWNvakxKY2JSRWNhS2duTGFzcHBlaVBXcm5HNE5FU2VS?=
 =?utf-8?B?WUZDUkliQ21aTDFvRmtNOGpHMURwTmVUL3NxWjdJWTllNHNLWjJXb1pGUmEr?=
 =?utf-8?B?eHlmRG5RN2l6Q1N6SHhYdzVsamNpUm03U0Y3RVFRenZGQ1hjL3dMSFhkYW1G?=
 =?utf-8?B?L1pQMENRM3lBOFJsYXE1bGYrVDhEWFJlWUx1QmVBVXI4bnh0a0hGTU1hUUJt?=
 =?utf-8?B?eFdUK3hWcCt5Y3hLbWRMT01TUmJ4cll3eUttS2JTalcybE5UOGxEamNKdE9y?=
 =?utf-8?Q?n400BVVw1rGX4Q2IsGq8da8=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2226a31b-1093-4623-c2d1-08ddbfb4eb62
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 13:23:12.2797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQJyllB+suNCHlwzN/+f2Q5FY+OB0ReuGkS4kOAkKTZ7fvGIHlTR+4mlTDwox2GSjwnXIJIrzMF/oyFrI/PRKm6JCQPyoLBtXV2VblBUiHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT1PR01MB9276

On 2025-07-10 00:56, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "WARNING:inconsistent_lock_state" on:
> 
> commit: d06e66c6025e44136e6715d24c23fb821a415577 ("[PATCH v14 2/3] sched: Move task_mm_cid_work to mm timer")
> url: https://github.com/intel-lab-lkp/linux/commits/Gabriele-Monaco/sched-Add-prev_sum_exec_runtime-support-for-RT-DL-and-SCX-classes/20250707-224959
> patch link: https://lore.kernel.org/all/20250707144824.117014-3-gmonaco@redhat.com/
> patch subject: [PATCH v14 2/3] sched: Move task_mm_cid_work to mm timer
> 
> in testcase: boot
> 
> config: x86_64-randconfig-003-20250708
> compiler: gcc-11
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> +-------------------------------------------------+------------+------------+
> |                                                 | 50c1dc07ee | d06e66c602 |
> +-------------------------------------------------+------------+------------+
> | WARNING:inconsistent_lock_state                 | 0          | 12         |
> | inconsistent{SOFTIRQ-ON-W}->{IN-SOFTIRQ-W}usage | 0          | 12         |
> +-------------------------------------------------+------------+------------+
> 

I suspect the issue comes from calling mmdrop(mm) from timer context in a scenario
where the mm_count can drop to 0.

This causes calls to pgd_free() and such to take the pgd_lock in softirq
context, when in other cases it's taken with softirqs enabled.

See "mmdrop_sched()" for RT. I think we need something similar for the
non-RT case, e.g. a:

static inline void __mmdrop_delayed(struct rcu_head *rhp)
{
         struct mm_struct *mm = container_of(rhp, struct mm_struct, delayed_drop);

         __mmdrop(mm);
}

static inline void mmdrop_timer(struct mm_struct *mm)
{
         /* Provides a full memory barrier. See mmdrop() */
         if (atomic_dec_and_test(&mm->mm_count))
                 call_rcu(&mm->delayed_drop, __mmdrop_delayed);
}

Thoughts ?

Thanks,

Mathieu

> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202507100606.90787fe6-lkp@intel.com
> 
> 
> [   26.556715][    C0] WARNING: inconsistent lock state
> [   26.557127][    C0] 6.16.0-rc5-00002-gd06e66c6025e #1 Tainted: G                T
> [   26.557730][    C0] --------------------------------
> [   26.558133][    C0] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
> [   26.558662][    C0] stdbuf/386 [HC0[0]:SC1[1]:HE1:SE0] takes:
> [ 26.559118][ C0] ffffffff870d4438 (pgd_lock){+.?.}-{3:3}, at: pgd_free (arch/x86/mm/pgtable.c:67 arch/x86/mm/pgtable.c:98 arch/x86/mm/pgtable.c:379)
> [   26.559786][    C0] {SOFTIRQ-ON-W} state was registered at:
> [ 26.560232][ C0] mark_usage (kernel/locking/lockdep.c:4669)
> [ 26.560561][ C0] __lock_acquire (kernel/locking/lockdep.c:5194)
> [ 26.560929][ C0] lock_acquire (kernel/locking/lockdep.c:473 kernel/locking/lockdep.c:5873)
> [ 26.561267][ C0] _raw_spin_lock (include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154)
> [ 26.561617][ C0] pgd_alloc (arch/x86/mm/pgtable.c:86 arch/x86/mm/pgtable.c:353)
> [ 26.561950][ C0] mm_init+0x64f/0xbfb
> [ 26.562342][ C0] mm_alloc (kernel/fork.c:1109)
> [ 26.562655][ C0] dma_resv_lockdep (drivers/dma-buf/dma-resv.c:784)
> [ 26.563020][ C0] do_one_initcall (init/main.c:1274)
> [ 26.563389][ C0] do_initcalls (init/main.c:1335 init/main.c:1352)
> [ 26.563744][ C0] kernel_init_freeable (init/main.c:1588)
> [ 26.564144][ C0] kernel_init (init/main.c:1476)
> [ 26.564402][ C0] ret_from_fork (arch/x86/kernel/process.c:154)
> [ 26.564633][ C0] ret_from_fork_asm (arch/x86/entry/entry_64.S:258)
> [   26.564871][    C0] irq event stamp: 4774
> [ 26.565070][ C0] hardirqs last enabled at (4774): _raw_spin_unlock_irq (arch/x86/include/asm/irqflags.h:42 arch/x86/include/asm/irqflags.h:119 include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202)
> [ 26.565526][ C0] hardirqs last disabled at (4773): _raw_spin_lock_irq (arch/x86/include/asm/preempt.h:80 include/linux/spinlock_api_smp.h:118 kernel/locking/spinlock.c:170)
> [ 26.565971][ C0] softirqs last enabled at (4256): local_bh_enable (include/linux/bottom_half.h:33)
> [ 26.566408][ C0] softirqs last disabled at (4771): __do_softirq (kernel/softirq.c:614)
> [   26.566823][    C0]
> [   26.566823][    C0] other info that might help us debug this:
> [   26.567198][    C0]  Possible unsafe locking scenario:
> [   26.567198][    C0]
> [   26.567548][    C0]        CPU0
> [   26.567709][    C0]        ----
> [   26.567869][    C0]   lock(pgd_lock);
> [   26.568060][    C0]   <Interrupt>
> [   26.568255][    C0]     lock(pgd_lock);
> [   26.568452][    C0]
> [   26.568452][    C0]  *** DEADLOCK ***
> [   26.568452][    C0]
> [   26.568830][    C0] 3 locks held by stdbuf/386:
> [ 26.569056][ C0] #0: ffff888170d5c1a8 (&sb->s_type->i_mutex_key){++++}-{4:4}, at: lookup_slow (fs/namei.c:1834)
> [ 26.569535][ C0] #1: ffff888170cf5850 (&lockref->lock){+.+.}-{3:3}, at: d_alloc (include/linux/dcache.h:319 fs/dcache.c:1777)
> [ 26.569961][ C0] #2: ffffc90000007d40 ((&mm->cid_timer)){+.-.}-{0:0}, at: call_timer_fn (kernel/time/timer.c:1744)
> [   26.570421][    C0]
> [   26.570421][    C0] stack backtrace:
> [   26.570704][    C0] CPU: 0 UID: 0 PID: 386 Comm: stdbuf Tainted: G                T   6.16.0-rc5-00002-gd06e66c6025e #1 PREEMPT(voluntary)  39c5cbdaf5b4eb171776daa7d42daa95c0766676
> [   26.570716][    C0] Tainted: [T]=RANDSTRUCT
> [   26.570719][    C0] Call Trace:
> [   26.570723][    C0]  <IRQ>
> [ 26.570727][ C0] dump_stack_lvl (lib/dump_stack.c:122 (discriminator 4))
> [ 26.570735][ C0] dump_stack (lib/dump_stack.c:130)
> [ 26.570740][ C0] print_usage_bug (kernel/locking/lockdep.c:4047)
> [ 26.570748][ C0] valid_state (kernel/locking/lockdep.c:4060)
> [ 26.570755][ C0] mark_lock_irq (kernel/locking/lockdep.c:4270)
> [ 26.570762][ C0] ? save_trace (kernel/locking/lockdep.c:592)
> [ 26.570773][ C0] ? mark_lock (kernel/locking/lockdep.c:4728 (discriminator 3))
> [ 26.570780][ C0] mark_lock (kernel/locking/lockdep.c:4756)
> [ 26.570787][ C0] mark_usage (kernel/locking/lockdep.c:4645)
> [ 26.570796][ C0] __lock_acquire (kernel/locking/lockdep.c:5194)
> [ 26.570804][ C0] lock_acquire (kernel/locking/lockdep.c:473 kernel/locking/lockdep.c:5873)
> [ 26.570811][ C0] ? pgd_free (arch/x86/mm/pgtable.c:67 arch/x86/mm/pgtable.c:98 arch/x86/mm/pgtable.c:379)
> [ 26.570822][ C0] ? validate_chain (kernel/locking/lockdep.c:3826 kernel/locking/lockdep.c:3879)
> [ 26.570828][ C0] ? wake_up_new_task (kernel/sched/core.c:10597)
> [ 26.570839][ C0] _raw_spin_lock (include/linux/spinlock_api_smp.h:134 kernel/locking/spinlock.c:154)
> [ 26.570845][ C0] ? pgd_free (arch/x86/mm/pgtable.c:67 arch/x86/mm/pgtable.c:98 arch/x86/mm/pgtable.c:379)
> [ 26.570854][ C0] pgd_free (arch/x86/mm/pgtable.c:67 arch/x86/mm/pgtable.c:98 arch/x86/mm/pgtable.c:379)
> [ 26.570863][ C0] ? wake_up_new_task (kernel/sched/core.c:10597)
> [ 26.570873][ C0] __mmdrop (kernel/fork.c:681)
> [ 26.570882][ C0] ? wake_up_new_task (kernel/sched/core.c:10597)
> [ 26.570891][ C0] mmdrop (include/linux/sched/mm.h:55)
> [ 26.570901][ C0] task_mm_cid_scan (kernel/sched/core.c:10619 (discriminator 3))
> [ 26.570910][ C0] ? lock_is_held (include/linux/lockdep.h:249)
> [ 26.570918][ C0] ? wake_up_new_task (kernel/sched/core.c:10597)
> [ 26.570928][ C0] call_timer_fn (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:262 include/trace/events/timer.h:127 kernel/time/timer.c:1748)
> [ 26.570935][ C0] ? trace_timer_base_idle (kernel/time/timer.c:1724)
> [ 26.570943][ C0] ? wake_up_new_task (kernel/sched/core.c:10597)
> [ 26.570953][ C0] ? wake_up_new_task (kernel/sched/core.c:10597)
> [ 26.570962][ C0] __run_timers (kernel/time/timer.c:1799 kernel/time/timer.c:2372)
> [ 26.570970][ C0] ? add_timer_global (kernel/time/timer.c:2343)
> [ 26.570977][ C0] ? __kasan_check_write (mm/kasan/shadow.c:38)
> [ 26.570988][ C0] ? do_raw_spin_lock (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-arch-fallback.h:2170 include/linux/atomic/atomic-instrumented.h:1302 include/asm-generic/qspinlock.h:111 kernel/locking/spinlock_debug.c:116)
> [ 26.570996][ C0] ? __raw_spin_lock_init (kernel/locking/spinlock_debug.c:114)
> [ 26.571006][ C0] __run_timer_base (kernel/time/timer.c:2385)
> [ 26.571014][ C0] run_timer_base (kernel/time/timer.c:2394)
> [ 26.571021][ C0] run_timer_softirq (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:262 kernel/time/timer.c:342 kernel/time/timer.c:2406)
> [ 26.571028][ C0] handle_softirqs (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-fallback.h:457 include/linux/jump_label.h:262 include/trace/events/irq.h:142 kernel/softirq.c:580)
> [ 26.571039][ C0] __do_softirq (kernel/softirq.c:614)
> [ 26.571046][ C0] __irq_exit_rcu (kernel/softirq.c:453 kernel/softirq.c:680)
> [ 26.571055][ C0] irq_exit_rcu (kernel/softirq.c:698)
> [ 26.571064][ C0] sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1050 arch/x86/kernel/apic/apic.c:1050)
> [   26.571076][    C0]  </IRQ>
> [   26.571078][    C0]  <TASK>
> [ 26.571081][ C0] asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:574)
> [ 26.571088][ C0] RIP: 0010:d_alloc (fs/dcache.c:1778)
> [ 26.571100][ C0] Code: 8d 7c 24 50 b8 ff ff 37 00 ff 83 f8 00 00 00 48 89 fa 48 c1 e0 2a 48 c1 ea 03 80 3c 02 00 74 05 e8 5f f3 f6 ff 49 89 5c 24 50 <49> 8d bc 24 10 01 00 00 48 8d b3 20 01 00 00 e8 87 bc ff ff 4c 89
> All code
> ========
>     0:	8d 7c 24 50          	lea    0x50(%rsp),%edi
>     4:	b8 ff ff 37 00       	mov    $0x37ffff,%eax
>     9:	ff 83 f8 00 00 00    	incl   0xf8(%rbx)
>     f:	48 89 fa             	mov    %rdi,%rdx
>    12:	48 c1 e0 2a          	shl    $0x2a,%rax
>    16:	48 c1 ea 03          	shr    $0x3,%rdx
>    1a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
>    1e:	74 05                	je     0x25
>    20:	e8 5f f3 f6 ff       	call   0xfffffffffff6f384
>    25:	49 89 5c 24 50       	mov    %rbx,0x50(%r12)
>    2a:*	49 8d bc 24 10 01 00 	lea    0x110(%r12),%rdi		<-- trapping instruction
>    31:	00
>    32:	48 8d b3 20 01 00 00 	lea    0x120(%rbx),%rsi
>    39:	e8 87 bc ff ff       	call   0xffffffffffffbcc5
>    3e:	4c                   	rex.WR
>    3f:	89                   	.byte 0x89
> 
> Code starting with the faulting instruction
> ===========================================
>     0:	49 8d bc 24 10 01 00 	lea    0x110(%r12),%rdi
>     7:	00
>     8:	48 8d b3 20 01 00 00 	lea    0x120(%rbx),%rsi
>     f:	e8 87 bc ff ff       	call   0xffffffffffffbc9b
>    14:	4c                   	rex.WR
>    15:	89                   	.byte 0x89
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20250710/202507100606.90787fe6-lkp@intel.com
> 
> 
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

