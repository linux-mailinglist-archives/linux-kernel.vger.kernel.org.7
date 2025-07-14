Return-Path: <linux-kernel+bounces-729269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E437B03422
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 03:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254F71899D1F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 01:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937A71E89C;
	Mon, 14 Jul 2025 01:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DBG6yUxr"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2046.outbound.protection.outlook.com [40.107.212.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F5F2E36E5
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 01:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752455730; cv=fail; b=H5jG4FAt0ucniRJ13CrtMarpLQattGeglRIrhh1UeeCox6meJyCY7ESFS2XMj9ff+BSs99e4+fSymAZ2jeroUU4Js6f6m3SGG53VXr92QqL1B2B1vPuPY/Ao47tzwz6vwkguuinaHPOYMwdm2YghanL8JfktY6/S3uJL+FjM77k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752455730; c=relaxed/simple;
	bh=B3R1Mzc/BEfFQxrwLlJf4l4u14ZiIyEcq8V7W5Po55g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SDGghHO2wizl5tadMvtWIRAsxs6uYyr5Cc6qjHj8U5m1oFf+mbahsYAJ/X3i9orDOwvqAsHjA2z+LnhHTlxlEZfouteq+8yQzmB4nQC9f205zdLShRqNUZbKcKmHr4o0xEBIJeluCyp5MabFLqY+e+QRiZbHgoyf+GrPnWBnBUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DBG6yUxr; arc=fail smtp.client-ip=40.107.212.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rr1RuziaLEOgFUdps57L5LFMYrsJArWx26wgkYSMAO6XdFBfpBeoDpVPYs2g0+yNoRBucnYyNWICq0H00uM3zGa9ocvzmGmioLxlQ0CfNtsjlC4qIyCvKMKQ2lK3JOxR0q3YkIY6T+Qrb7cXbrVdPWSPXFjm5EdZBxIMHNaiIeFrVAg0pgFa5jAHzHm03rBn4eU4nt3RtVgLShMPplg5Sqvc3y1O1mDbAL9Hw9SNMyThgjErPM7czhUqJK3nGf4yxQu6U603rw+Thz5u7+mfnx84zJh6vweWvlYMzQsG89hmf79nqgRMxiPhB279ljJz4hO52Xy2yFxxTqjYikoo4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFk/wy6AvJrrit+/vhvZLhYU5ApZ057lrd1euR6v/kQ=;
 b=a22pba17C/xYvJeNL8TBgRKGqyXFvUMGj/yh8be00zjmwwC6fG8Ygo+fwfq+4Y4ceXaHUeLFhDGm0Ui6+7F1HADiYZF91mvsg3eB5g0e9u8PzCy5Wx+VnaL3IdYQ1xE8SF15Le7piNOC5j6mUH/yf2rfSdGyreCjSh1tJG435g6F0YysVxNVBMUPNY0l3zJq47Q8GEQH5Rb3pu/tYWhDOxMHJVE5ZWIHWtqfLVlK+dfpXj0mysPEpEpoHv0+2UeOOpZIFb9XBAW3Jr9uo4cXYDNY85XkZU9O0p7iiYV6xURgP8jZsvfOcv4esw8wui+0cwF+QfwKaSUgm+ri2d8rCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFk/wy6AvJrrit+/vhvZLhYU5ApZ057lrd1euR6v/kQ=;
 b=DBG6yUxrd96fFr7mfcME5IgyumG738kEma9jOMbXpPYK+rgWxzjg3FVSKwIfPUYA8j7ffWRMFgyYMqMNG+q4+QoJhvAz5CrqMKnebCxrHllWG/c5qXNiUILfINq1ux7YClnhF/YOb76LRLnuHo1AScOWtzgNJyT8LtqVC504AAIaX7epNLXSgDwaQgY3WFDLhzG0ucmedBMcnxGggYSXSxSuvNiHjp9Q8vPf7K4/wCFbocsBqgfEqWA6Wt6Rd9WtjYAQQ+XzV7YrCkpgsJfBDRufw9yOwkn6om+/JmsJ6osUx6QOzml0504vOW0cNjTMvWj260JigggsYMp4dpbsMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13)
 by CH3PR12MB9098.namprd12.prod.outlook.com (2603:10b6:610:19e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 01:15:24 +0000
Received: from PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251]) by PH8PR12MB7277.namprd12.prod.outlook.com
 ([fe80::3a4:70ea:ff05:1251%5]) with mapi id 15.20.8901.028; Mon, 14 Jul 2025
 01:15:24 +0000
Message-ID: <89bf7747-86f7-46c0-9252-9530762f910c@nvidia.com>
Date: Mon, 14 Jul 2025 11:15:16 +1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] mm/huge_memory: move unrelated code out of
 __split_unmapped_folio()
To: Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>,
 linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins
 <hughd@google.com>, Kirill Shutemov <k.shutemov@gmail.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, linux-kernel@vger.kernel.org
References: <20250711182355.3592618-1-ziy@nvidia.com>
 <20250711182355.3592618-2-ziy@nvidia.com>
Content-Language: en-US
From: Balbir Singh <balbirs@nvidia.com>
In-Reply-To: <20250711182355.3592618-2-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SY5P282CA0016.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:202::12) To PH8PR12MB7277.namprd12.prod.outlook.com
 (2603:10b6:510:223::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7277:EE_|CH3PR12MB9098:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a9665b1-3dc1-4a78-c716-08ddc273e8c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWJtL2lQcmR6QmtuSEhRaDQ3ZWNhcDB4ZXRHRE95MGRLajJWQ1BnMzQ5ZWto?=
 =?utf-8?B?NVRBRkFwTE1zRGlNMnRZVzJldHNTaVUvMnJFb1gvbXZkZUZSdjREcFRFdXQ4?=
 =?utf-8?B?V3lTWWVDTEFUYlc1NS9JdENEMGFqSXcxUWZCR1Jyb1VpTVh2eWQ4MUlOeU9H?=
 =?utf-8?B?SDB1U3BzUmNGeWlGbjRyRVJkWm9xSzl6eXhOUGIzQlFaK25xZlJlUm1JcmE4?=
 =?utf-8?B?c2xhMS9ncjl0MEpoK3RrMldOOFRBQVFWRGFmNVhDbms1M1U5Vml3U3NpcVFY?=
 =?utf-8?B?M3JlRWxnQ2FRYVJVMThXc2dkT1B4L2ROUkxIZDRRRE9nWWUvMUlIdkRWMFQ1?=
 =?utf-8?B?V25CeGpMaE5uRzdxWE9BZjk3WHlUcFpManNtazVsSHFWVERBMFY3Z0hqWUNv?=
 =?utf-8?B?eThjU1BMKzVLWUhiT0xBbml6eXhTalpiakpxaU9yKzc1NXVDOGhHRDRWNUhF?=
 =?utf-8?B?cTFNYmdvSGswOTM5RFVrTFZzblRwUkUwVFg2UmNVY1U5bXZQU0NNNWRGWnBF?=
 =?utf-8?B?VlhZV3BxejlxSG1VRDg3RFJCL2FJTXZETkhhU2FZUVNHZEVVKzVNZHRkTzVI?=
 =?utf-8?B?WDJEaWtkOWV1UndPVm5HT2s5Ym42cnQ4ZTJpTXpTRVNieTJOeS9xUlc1OWhj?=
 =?utf-8?B?bzN6MXVTUjdaQVk2alRXTEcwalp5cExHNzU2b0l5NUptL1p6UjdYQmtrOFlU?=
 =?utf-8?B?WEFBSXl6d2hWK2lxamNad0VzNVU1a0RaOFNPSjRpbVgvZTByTjd4ZFYyZElW?=
 =?utf-8?B?dTZJWG91YWlGRTlYQzNyVFNlQ0dmTVpiQ0NzdlRMM056THZldHlxaG53NTJs?=
 =?utf-8?B?UEFGaUt3T2dyazhkWGVYbXFadDQxdVF6WDNEL1pGS29BRWEvNjhUNkxwNTgv?=
 =?utf-8?B?SkhQRUNIVjVpVSt0QW1RMFIyZ0lyUjJkdnJSR1Zld201dzNTWU1Wb3Z2OEFX?=
 =?utf-8?B?c0Izc1NDY3NJTVpjRnNFbWQ1ZjdXb2hDSUVkREpDVzhDczVGMk1ObWJtWkZm?=
 =?utf-8?B?RFNmNlRRbFlSQzVwd0lLUVNEckxraEkzdTd2V0NlYjZvUGlOQ1NsdUJOdTQ5?=
 =?utf-8?B?NklDTmRHS2Z3ZUJRd3NoRGZWQ3d5aXZDUUl2Wmc4TWdSWURFTFhLYVdpOUgv?=
 =?utf-8?B?bW5WZEdxc3JkTjNjbEhza1N2ODZuYjlWeGVsdGJtcGxuTXd5c0tEazVyQXgz?=
 =?utf-8?B?OGpnY1hGVlpUVDYrRS9pZTJEOFRVaDQwaXkyay9RMFkxbW8vQmVTUjJMOENT?=
 =?utf-8?B?ejVwUExyOVlmRlZDRTdlREUvcFFNQ2lZL3lLQy80Mzl1Tm4vQkNVTVVYby9V?=
 =?utf-8?B?ZkhNWUUyS2FCaFpBWDBRQm15RWxBVkVERWowbVo1VWl2MWl1VFZ6eDdFdGtU?=
 =?utf-8?B?Z0xubit2WHBDYzFFREJRKzdtVEZaaWNjUmllVFczRGROYUZZSXJ3N1VyRDVh?=
 =?utf-8?B?SE13UENVZzFrWmlZdVVRWXJ0aXdUR2tycW5GSmxuTzVzNFZxd0JEMm9OTE9Q?=
 =?utf-8?B?YTRXUDRTQzJheXQwTUZGS1hsSjMvV0F3dmM3dHhWa1AwR1hwY3FRSHFMelpi?=
 =?utf-8?B?TnZVczRwdkVZbzdRTXBaNm9uV2NsOTBxMGc1ZHluT25RUStCUkUyQUhna1do?=
 =?utf-8?B?eUV5dUF1bnBidGlMOFdhSEh5bEhhbjU4UkFoVllxUUorSUhzeDVJTHhKZ1Ja?=
 =?utf-8?B?TGUxV2FjVkUzSnRWaHp0dUpsbU5YM3REUmg0N3VRZlNFaVJ0NlQ3K2RpTDI1?=
 =?utf-8?B?eXpLa0pnd3UrbWlYcjA4dWF1NEFqNW9rUnNDZW1Wd1AxUkR4ckZUTVlKVmk5?=
 =?utf-8?B?TVFDZE5KVURYM3V6bDVKN04yK1V6L1JDYlVQak5KcGc2YXkya1I2dzNKWkZI?=
 =?utf-8?B?UnhBMzhTdWdyT2h5Q1ZPa1FrTHhkaWhFcCtGVmNwWmRzbFM0eGw3Yy9KcDJ2?=
 =?utf-8?Q?llLl0PcUou4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7277.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cDVqVkZpM3FGYnRyb2xIaGF5UnpUZkpVNnA0ZVcyUDlSM0c1V05tbDgvRGk0?=
 =?utf-8?B?eDJwR1lHSHlCbUw0UExnZXpCVFBjWk11ZFRuQnRMc0E0QWg1L1hPdis1WUxx?=
 =?utf-8?B?ODVRL0Q2UWl5dDhQTmkyZ3lGRDFicmhIaEhObGVydnNMRkorVnhldUNmWVV1?=
 =?utf-8?B?K212blZhZk1vNkdMVU9VeVZIYThSL3R0ems1TWNRaGJOMmQ1YVl6cHlnbENW?=
 =?utf-8?B?Tkp3ZE85VkN2dDFUS2lGMTZkcExLQ2d5Z3h0Q3dsTWpJakhCWkpDWTYwVDg4?=
 =?utf-8?B?RkVvT2gzU0ZzNmJ3MFNFOXIyMUZXMStlSzhWQnpkaVBONDc2TThCSWlFSTdI?=
 =?utf-8?B?dkhiT0pubTF4WnZQZ1BwOEh0UHRQUTN4bDRTRU1KdGQ1SzZ1SS85Y05JK0d2?=
 =?utf-8?B?SDlpbTV2M3A4OHlQdHIzanpHM1RHa3pCQ1hkQzU1c2hqWDFXaDhESTA2OGRs?=
 =?utf-8?B?dEU3a2h2R1JRNjNPbkZPV09zOWQzT1FRSU5yaVlNTE5RemsyUmpuU0dsKzFj?=
 =?utf-8?B?bUZvSkRZQ1FneDJaZFpQbnd1bjExOVBycTBFRkNUc0ptZU9TNnVjUVB1V0xM?=
 =?utf-8?B?OHhNYktMRnF5ZUZuUm5WaERWS2RqRzdEOVdzckFHOUEyd0FBSnFYcmluVGsy?=
 =?utf-8?B?WkFEWlhmcndTb28wZUg4MTdJdkp5K0tybDBaYzNrcmRjMDl6T040YUlpSitY?=
 =?utf-8?B?VGJ2WlBWMlpoR3Q5Q2FQMWdmSnlibzExZnNEaHYyZm51Vlg3OFhuYXlMY3NR?=
 =?utf-8?B?SERIdkdhZE5PS0Vub3kvL0dqYjY0Mlp3T3BsUTg2eUZ4Mng5WHBsZWVYRGEr?=
 =?utf-8?B?T1lWTzQ5NlA5dXpDemhXVFBwbXU1eTNqdXlJL2ZPdGRpcmVEeXNaZ0NOQTFn?=
 =?utf-8?B?dy9NNHB2cFZ5VjY0c2xzbE94dE1xcXpzaGwrTWtsZG9lcmdrQmR4TFJsWVBN?=
 =?utf-8?B?KzFaeXZBbHVZZ1ZPdGhMR0M5VnNaK3R1NVhkUTRQVzMvVFVnTFZYTUg2S040?=
 =?utf-8?B?dGswNVRBMXVuSUJjaUpDSW1QRDh0YkZuVDFWaERjTjgvaWJaYm4zWEZPWU1N?=
 =?utf-8?B?ZW4zV2J3bmJMWXJzcHI0OFNMSmNXd21lVWEvbkdTVkRudVlMYmhwYVd2cXVl?=
 =?utf-8?B?dlROL2NSN0xkTnNVaVRTNFlnREZRTXJNY0FsdThYM2VTTEZWTGZkUlROam9W?=
 =?utf-8?B?cGd5TjYwQm1CMHowRzZTNTFYbGtKL3RtaU01N0VEZmJ2YkJvak5hTGkyL3pa?=
 =?utf-8?B?MEgrVGxTZzB5OFNVdkRlWUxJV0FEVnJqVXRvODBUNEQvZFl4dzZDcjNBWjJx?=
 =?utf-8?B?R081L3Y5NkpHaW9hTjNkZndDZkRQUDFYVDVacU5UVTI0bmtlYm4rd1lqeUpn?=
 =?utf-8?B?eSt0ZkV3TjE3dkw1bThMYk1Icm9qbFd6a0h2SmkxY01BY1k4bDZmMHhUWWEr?=
 =?utf-8?B?L2RsWGxXUUk1cU04S1R4aHhQRHp4ZHhLYlBmaWl2ZWxPTVJ5Ri9ZenRXMmVO?=
 =?utf-8?B?REVGMjN2UXVKMlRoNUV0SXE5QXJFOFZYNzdETFpBbGt4RVBYRG1DRGp3RHc4?=
 =?utf-8?B?dFg4VmJKemNMSHBSMnZiUFFWOXhKU2NuVVd2T2hVUkM5ZXB5K2ZIU3loVVF2?=
 =?utf-8?B?azFVVDJDL1ZIbFM2L1hDUkE5Tm1rN1k5LzYxM1ZTR3Fib1pVNmRIVG91NzVx?=
 =?utf-8?B?QWxVYmxJeXB4Z1R1VTlnaFhId0dFU29UV1ZjbC9hUGs5L0ZGeFI5dUFBcmZ2?=
 =?utf-8?B?RS9CWkpuMnFScnVLM09RWWQ5bmt0NGlNQTVTaGJYWmt2TDNlZThQc3VraWVr?=
 =?utf-8?B?UVNsSHpGdFo2UFJqbytnTi9DTUlMMzN6cmo4WVdTMjVmclhRZjdXUUh5dG1L?=
 =?utf-8?B?ZnZnWGphZkRqZm93VFAyeVFIM3AyWCtnbEdQcFg2VitVaWRZSnRaSFVudVhN?=
 =?utf-8?B?dmhVdUIyOGZuOWVlL0VMNkx3ekVhbmx4d2VXeWNiTHJxbnlYcGlNRUJjS295?=
 =?utf-8?B?RFJFSkJPcVVzaVFTcExRaks0TXRNL2J6blNQeDFzczFkMEw2akVLKy9Wc3BS?=
 =?utf-8?B?bHg0c2ZNay9kdVJUUkYwYmhFenRJZzNxK0dweFU5Nk5obGtTRDFOVjYyR2Yr?=
 =?utf-8?Q?pu7tC4lF8x3RwECkcvD8rxbS9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a9665b1-3dc1-4a78-c716-08ddc273e8c4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7277.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 01:15:24.4277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1h2FqhzUeHBXwvGzwRql7SCAaN/hV70S4hvQOR9rc/b6wG0AxB/CPvTzgj265gWOLF5tY5TFN76IpvT5gtw4Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9098

On 7/12/25 04:23, Zi Yan wrote:
> remap(), folio_ref_unfreeze(), lru_add_split_folio() are not relevant to
> splitting unmapped folio operations. Move them out to the caller so that
> __split_unmapped_folio() only handles unmapped folio splits. This makes
> __split_unmapped_folio() reusable.
> 
> Convert VM_BUG_ON(mapping) to use VM_WARN_ON_ONCE_FOLIO().
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>


Acked-by: Balbir Singh <balbirs@nvidia.com>

