Return-Path: <linux-kernel+bounces-848893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 309A7BCEC3B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 01:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4004A19A611B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 23:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7DF32836B0;
	Fri, 10 Oct 2025 23:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UubJplWR"
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011045.outbound.protection.outlook.com [52.101.62.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25F7280CD5
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 23:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760139485; cv=fail; b=W5RMRbLmy/MYrKC1jIDz0xTSGa3f6VsRahK7LNzVQH7rosT+lKFBh0KsJESivqvQS36YarwZKleQPIrmN5h+KFRrpY1L+TNNtEbhDY5GpIjkn7ch9/XHmh944Z9D40l/O0riGlx7KyYz9D/7gMKlNvMSrRNMv7BgmA7AlOfltao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760139485; c=relaxed/simple;
	bh=U7YzF/3i0jWfCvt0uoCrdeiT67Og4WochNIs5tPlNfQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rvdCrLBUK8fmAFMibZEMzFSEeNpkwBuMEyorsi9PktkXuaj+iYnTb+NiRg3JFmxJ69b6CKVfvle2jycdzq9h2BLLWODvYu39AwnuOK5vZ9XvaERGg5zSopmnyzDefE8Vt/txg5sRN5fevNGmmP/rmdwR5CCFaLP2PQr+DFw9f+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UubJplWR; arc=fail smtp.client-ip=52.101.62.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KeyIUlPo8aIzZY3n27cK8LblVfn0kJFZ54oh6v1bgSrmuz4W3DO/MYsglGQUvx+SdV4a+dqUaGsAcImTt+/xUGsks6ylMZJt0JJCokdk9WyTDg5gwW8ci/P9sRnwCoEYPS2yVq8ZMOSOYxHchY37JiQYb+SKb3wQIVJXO7Nu/1UJqkFw2NYESWH086zXl4HY7Zz4E4Q9t+74l/UclX5lgLNXblBDbOc384gJaYqNskxeW/mOn9lUUU5AF85TXVeMuF/a8gSBO38meO5o2HU3GXzxVZ9bfea+3+Ye+mAoP6PhORjg3NaGBWhjxvjXu7N0JerxJ2vFCSPCRBmYB/10Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=glVN7KVxORuaulFxUfxWPXLNLlduAF/jqpMTx2oRu9Y=;
 b=sdRBhqche5QRNSG5S9q1kDVHkI2T1h/bR2oirnazBM+lWrG9v68nSfo69P3Vrw70BBIJnqgvepffJUgSBWZ48RNTP068Ps7ImuYkuN5zuaYX9/w6xI/u7wvcWFQUevCp73uuSxIgoHwQjhoGqyVycE+1o5H0Ypnv58qMiLZ8T5Vh7NlDLuDHvgfUH39wcbxrPTrgng9BrJDyIpPYCpImFf91+A1hp0tzshbV1LFGAYRIpb7lBJ1DMfFZYha42tHPOHRHHe+tWY7+tD3LG9wvVHmhimRHUq0FVyR+RcK+PNJliD79VhpMBa5ORw1pEUIjeuZgZ5jiqcxAbo0FGOxspQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=glVN7KVxORuaulFxUfxWPXLNLlduAF/jqpMTx2oRu9Y=;
 b=UubJplWRgVkZvSG7ovKWMLay6/tyJUsn0NwazNU0f8zF77qo1yJxRUflwEtdw6XHbSPZxJfkWYgwW2gNFtk5PQ6usTgfvAcSgRHKMzR+sF6BTwk7hHprBzrk3Xwx/dFTfB8798hWA3GSQNl1FNPUQk3VhqxStxa8XJLoiaKd+6A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc) by LV3PR12MB9403.namprd12.prod.outlook.com
 (2603:10b6:408:217::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 10 Oct
 2025 23:37:56 +0000
Received: from IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb]) by IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 ([fe80::8d61:56ca:a8ea:b2eb%8]) with mapi id 15.20.9115.018; Fri, 10 Oct 2025
 23:37:54 +0000
Message-ID: <3ad9c3ff-12be-47b8-8bcc-fdf4f1e8fbb7@amd.com>
Date: Fri, 10 Oct 2025 18:37:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] x86/resctrl: Fix miscount of bandwidth event when
 reactivating previously Unavailable RMID
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, tony.luck@intel.com, Dave.Martin@arm.com,
 james.morse@arm.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
 peternewman@google.com, eranian@google.com, gautham.shenoy@amd.com
References: <0475e18db309c3c912514a6c4e7f7626297faa2b.1760116015.git.babu.moger@amd.com>
 <9771a165-e7dc-4e34-960c-37b17bd996b6@intel.com>
Content-Language: en-US
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <9771a165-e7dc-4e34-960c-37b17bd996b6@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0009.namprd11.prod.outlook.com
 (2603:10b6:806:d3::14) To IA0PPF9A76BB3A6.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bdc)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PPF9A76BB3A6:EE_|LV3PR12MB9403:EE_
X-MS-Office365-Filtering-Correlation-Id: 36fd3552-7d7c-4b94-5e2e-08de08560837
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0NLM1dja0RBZERsdDJsdzFmQzBSbVhqVmtBL1RBL1JBWjI2NHpKTjU5azlO?=
 =?utf-8?B?azV1YkRrd2VmazF0MkxXb1g1WTkxOUVRU1luZ1FjelNRK3BHR1FFOURLRWw4?=
 =?utf-8?B?SWpIZkliUnpCSUp0alEwZGxUMlppcjdrNG1LQUlUZ0Y3KzhCYlpQMGRZNmtw?=
 =?utf-8?B?QS9WdGhCb3p2U3hGZUhJNjdYR1ZFNDRHSXdMaVErZzJodnRKV2pWT1ZmTnJr?=
 =?utf-8?B?aWdtTmdZMnhRUEVNbHpFQXJ2SjVRd2d4K0xLRkRHZDNXbTdlV3RsQWRtRzRi?=
 =?utf-8?B?QVFuWjhLQW1EdGViaEtEZ1p3YWJMWE11a2p1K0xieEVqdnlaVWphWGxRbTZu?=
 =?utf-8?B?VEp5MFd0amNGbEExbVl1dG92aFBFaHZ3OHBzRjhTeERxTDhPaUFBaDdFbVJV?=
 =?utf-8?B?aldLUWU3WFE2UHlaQkdaWWp1c0tubnprWEdTNVBZTTlPSnJibHdpNlRobE5P?=
 =?utf-8?B?SWlia2Z3b0VEanRreENpMXVBSHpUMFRPZncwQVpjOVozSGxSVVAzT0REMzM4?=
 =?utf-8?B?OHhSeWQ1WGJ2b003a0VXL1AyZ0RxWHdhdStOMzNYMTZBNXVGeG5mQ0djNlFB?=
 =?utf-8?B?VlA1aHJzN20rV2tsSy9WdVNuU2Z6dUdycXJhMXRkdzQ1WHcvdnRGbE42bUVZ?=
 =?utf-8?B?NFdMQmw3Q1NPamhYcWtTOTUySU93dTVOdCt2Y2VQaEFiSGpMeklCMHBnYklj?=
 =?utf-8?B?ZyttS2dvMzloZEJ0RllQQm5sMVhIZjJCWkZkdTRkbXpkZnZRVDRQVncwVHpY?=
 =?utf-8?B?ZXgxdmRqM0R5SVNlUEswdWUvdm5UT2hyWnlDM1dHSnltbFlXMnZWSVZVUUdm?=
 =?utf-8?B?UzNYTDVJWG9ZK1BaWWh6U0s1Q2VJVkM4b1hXMnhjM0F0WlUyMXRuZjIxL1d2?=
 =?utf-8?B?YnhGemlZWWhuT1ZFUzRSVXRMSnZrK1RjZmoxTDhrRDBGZjVER0xPZm5UYVlE?=
 =?utf-8?B?RUduVmV2QXZBYWxuc2hBUzRCSk90dnFXK2t1UzY1NWQzWXlCUXlReTJvbldS?=
 =?utf-8?B?VGR6NlRyQnlmcUZ4V1VVZWt0OWMrd2FLd01vU2JEZ2dwdjUwZ0xFa0t2b1J3?=
 =?utf-8?B?YW5hZ3QxK1Z3ekt3ckpKaTB5VTlnWUg5c1YzTlpadjhrMnNrbEFreXREcFZ5?=
 =?utf-8?B?VjY4ZkQ5YXZEQVREbG5OcytFSzZzNHozUnM4dEFmblRaWlNJdHJmaXVSUFlO?=
 =?utf-8?B?aHIyZndRZDlrb2tuWlF5YzBXSG1rOTF0V0pKSnBvOEhiNWVzb1ZjMi9GNU8v?=
 =?utf-8?B?cmxncjdnYWVFTDA4cEYyaWFISUgwMEc2L1NnOFJPMFVKVDQ2a2J1c2tldFVQ?=
 =?utf-8?B?QlFQeUcrUmFJZyswSFUxeXpsd1BxRGlxeWp0RFlhNmk1UG5wd0E5OVZzUjgx?=
 =?utf-8?B?d0FKbkZoQVZmbXkxbEFZbEFNOVp3WjRyRWxZbmQrZEM3cFA1NGZDejFZcTMw?=
 =?utf-8?B?Zm9mV0ZBR3YydVgrWE15Vk55TUZKaHcrdnRiSGxQekZjaklVcDI5akZXM3FB?=
 =?utf-8?B?RkNGUVpVU2J6Y0dmRUdoU1dNUkIzMFhzNVU1SWg3Qmp5YjExc2Ria0xOMG1m?=
 =?utf-8?B?cWxQQy9EbUpmbzgzQTgxVEUyYnJHSzl0ZXN4bkQ3ei9pZGl6TnNVR1ZPZzV2?=
 =?utf-8?B?YjU2V1FTQmR1ZWlVZ0xHQzN4Q0hBSDhVMTVzMkF6SUlwUmM1bzBLbWhUYmp5?=
 =?utf-8?B?QWg1NVR5SFRiajluUUVud2dFdkJlSkxDZVo5SXhPdm8wUlREOEdEaWplYkxh?=
 =?utf-8?B?UXVpcWl6TnBJS2lrdkorbnA0ZEJLUit2aHRwVlQxbjVjT29hcU9ORUVBKzRZ?=
 =?utf-8?B?ZXlLekNPZUNFWE0xUm1oeXhtelFnSmUrd3ZURm5TZzdmRWRuTmxQWEx5cmxD?=
 =?utf-8?B?T3ZlMEFzR05JbEttditHZHp4NlRPbll2YmdCU2hqN2tLWWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PPF9A76BB3A6.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZEEyU0VkTEYrUmFMKzdIdkp3Q3orZi9tTUpvYzZkMlg0R2oxejN1MVZic2pK?=
 =?utf-8?B?TWVEcVArOUM4aXIvL1lmK3gwNTR5eENZb0lvYTZnaDlrOVhrUUkrcHl4L1Bw?=
 =?utf-8?B?RFhMVUNPT3FIOVBQV3Zmd1FzMWhwNmoyeU85emRocXRHUlFuNEJRYmVQdE9N?=
 =?utf-8?B?am5NaFpOblJ2Um9vYW1pOXZReEtUYmtXVTM5clpBMHN6a2VCdG1TVHJHSmJh?=
 =?utf-8?B?b3cvdDNwWEZsdmNkVlYxL3ViNGQ3Wisxc0hnMUExWEVNKytUc0J5UDRBTEM0?=
 =?utf-8?B?WFVPRXJwZnZuODF1WHAxSXh4dHZYWVY1WXJ4aE93azgwQlEzZk9vS2ZpU0g2?=
 =?utf-8?B?RnR5QmhXQnJ3QkxwS0xWQUNGR2gxRUdlQXhPQWZZVGhYbDZQbkhBVTNEaEhr?=
 =?utf-8?B?b1p5dHF0MG9oS0g5WU1rQ0UzcXlVTzIvSzJ1eDFMOEJMME9PWkR1WXFFSEUx?=
 =?utf-8?B?a0w2RXR1cjV1UTNubzU0bFNLM0Rma3hRQm9hS082U3ZZUzFWNFJkVnBYWHl1?=
 =?utf-8?B?Z25VT3FlMjFHeCt4RFh2Z3NiTCtnTXFGYktESmR3UHVZNnBvVDRreElWbEVu?=
 =?utf-8?B?U084NTdFUFNjYUV5Ym9ZbEFQc0VscnBuMTVIbDZHWnUyMzVieFpoWDR5a29S?=
 =?utf-8?B?R2xEWERlNGw2TFRKOUo3WG5Vb1NSdzNFc1RPWmlwSk93eFBhNDd1K0g3L3Zw?=
 =?utf-8?B?ejBVL1JFWGNldHFTUnE0cGYxVWVRS1BzOTEwVTJFMkgzQkg3TXVCUGxNSFcx?=
 =?utf-8?B?bHVTdXMwd0p0dG1OdXRwWDJBRk1EZVpobEJ5SlNoL291ak9od0hCTksrNEI1?=
 =?utf-8?B?OEdrNFFmL09waVdoRk9wd1lhMHlNd0poTDMzOVVHejdIZklkaTBIQkFBSkgx?=
 =?utf-8?B?dWx2Z0JPOEFyUUNqK1BWakh3TW94djdudWZRSE1MZjBzeEZ0RktOazdWK1NZ?=
 =?utf-8?B?OGlFdzg4N1ZZcEttVG1LUmxuTUtSNmR3aVNBd2tBaWV0TmFRUGlsZzVTUDNF?=
 =?utf-8?B?Z3VwK1VKSmpVQVBsOGNEMWxwVTlmTXV4TFdKZVh1MkE1aVJPQnRmaGQyWG1j?=
 =?utf-8?B?TytNQ1BVM2NYa2wrWnVUZFczaWUzUkZkNEhDOWMyZVlGSWVXOWNmd0RDSVNw?=
 =?utf-8?B?OEYwZzhGMjhYSmw2R0p6Y1NXYkI0KzR5QnkrOUhYa1puY0lhRUQ2RXY1WjRH?=
 =?utf-8?B?c0NlZ2xhUVI3N3NBcUlJa0E1KzVyUloxdmk1TUtZYkhTK3IxL25pTkxlVDM5?=
 =?utf-8?B?QTVTeFRDVmxRcG8wNzFXZWlBUzJBU2M3bjRqa25idTV3Wlo0R1hNWkltMmFW?=
 =?utf-8?B?bmhSS1FrdHhJd3UxdHR1d1BJeDl3d1JmNEtseHlMcnViR3MwSGNReEY2TkJy?=
 =?utf-8?B?TWlNeERRZnMyQmZFajNLRXdmN0hOR2VSenQ3UlpDLzZqNWlkbERrSHNxTU8x?=
 =?utf-8?B?a0k1N2JZRzlJVWNFVi9nekd4ODkxdTJLMW1QbnlqS1RxVmhQQUR4ZzJFRVZP?=
 =?utf-8?B?TWV2QVlLK3NyaERYYWxoV1U5MTZzK1BaMVU1MlFNa3E4WXU2K0pXSFFVb2VN?=
 =?utf-8?B?NnJCaXZtdGlzNzg5MnJEMlFiWG9qMVZVUEZRZ1Jpajk4N3MzYjZodVFSTXR4?=
 =?utf-8?B?a2lBTldxNVowdEozSnZ2bGtoYVVNQy93Y1h2Q2o0MzFLakR6c3Vad2V6bFhO?=
 =?utf-8?B?bmNMOURvanU2V0VybUpFVHhTSFo0YVZ1bnNnUGJCdFllaHdCQXY4Q0JuNnRZ?=
 =?utf-8?B?bzYxZlZKSVgxZGZodloyaGhTbGRaMlgxM3JaaUEvellBZ1d2UHl2Q3ZHVTNM?=
 =?utf-8?B?aFdzODJLcnFpMHFLUXAwVU1NN0RyeHZXUDdCd2Zqam5NUjBZeWZRT1FOSjBH?=
 =?utf-8?B?T2p6b1BiM3RDZDBxdUtMTktRcitpYVlPMVNYeE8wb3NCaVhDbE02d21nMzda?=
 =?utf-8?B?QlFNK09tNWRmbkxWV04zREZuNkdqQU16WWN3QW5DN0ROTnNROWZoOXhGQnpT?=
 =?utf-8?B?bHJXUGNDR1RYRkxNQnUyb1QwTWNCb2hXMEZtcnNGYWJySzJ1cVIyWDJKNHZS?=
 =?utf-8?B?MURUN08zL1Y1b1NZUTdlN2grZEJPZUJYWU83aEkzeUxBRWt6aXRxVkR6Nyty?=
 =?utf-8?Q?ivsQm8Nb7wPb/DLkC71GYtNfE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fd3552-7d7c-4b94-5e2e-08de08560837
X-MS-Exchange-CrossTenant-AuthSource: IA0PPF9A76BB3A6.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2025 23:37:53.6987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QKHk9tEi+KfhZM32OuWum44Dj9K5EEivoHt7sn9c1Y9K/4j3q8JlHrtPGXeS3KHa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9403

Hi Reinette,

On 10/10/2025 4:20 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/10/25 10:08 AM, Babu Moger wrote:
>> Users can create as many monitoring groups as the number of RMIDs supported
>> by the hardware. However, on AMD systems, only a limited number of RMIDs
>> are guaranteed to be actively tracked by the hardware. RMIDs that exceed
>> this limit are placed in an "Unavailable" state. When a bandwidth counter
>> is read for such an RMID, the hardware sets MSR_IA32_QM_CTR.Unavailable
>> (bit 62). When such an RMID starts being tracked again the hardware counter
>> is reset to zero. MSR_IA32_QM_CTR.Unavailable remains set on first read
>> after tracking re-starts and is clear on all subsequent reads as long as
>> the RMID is tracked.
>>
>> resctrl miscounts the bandwidth events after an RMID transitions from the
>> "Unavailable" state back to being tracked. This happens because when the
>> hardware starts counting again after resetting the counter to zero, resctrl
>> in turn compares the new count against the counter value stored from the
>> previous time the RMID was tracked. This results in resctrl computing an
>> event value that is either undercounting (when new counter is more than
>> stored counter) or a mistaken overflow (when new counter is less than
>> stored counter).
>>
>> Reset the stored value (arch_mbm_state::prev_msr) of MSR_IA32_QM_CTR to
>> zero whenever the RMID is in the "Unavailable" state to ensure accurate
>> counting after the RMID resets to zero when it starts to be tracked again.
>>
>> Example scenario that results in mistaken overflow
>> ==================================================
>> 1. The resctrl filesystem is mounted, and a task is assigned to a
>>     monitoring group.
>>
>>     $mount -t resctrl resctrl /sys/fs/resctrl
>>     $mkdir /sys/fs/resctrl/mon_groups/test1/
>>     $echo 1234 > /sys/fs/resctrl/mon_groups/test1/tasks
>>
>>     $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
>>     21323            <- Total bytes on domain 0
>>     "Unavailable"    <- Total bytes on domain 1
>>
>>     Task is running on domain 0. Counter on domain 1 is "Unavailable".
>>
>> 2. The task runs on domain 0 for a while and then moves to domain 1. The
>>     counter starts incrementing on domain 1.
>>
>>     $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
>>     7345357          <- Total bytes on domain 0
>>     4545             <- Total bytes on domain 1
>>
>> 3. At some point, the RMID in domain 0 transitions to the "Unavailable"
>>     state because the task is no longer executing in that domain.
>>
>>     $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
>>     "Unavailable"    <- Total bytes on domain 0
>>     434341           <- Total bytes on domain 1
>>
>> 4.  Since the task continues to migrate between domains, it may eventually
>>      return to domain 0.
>>
>>      $cat /sys/fs/resctrl/mon_groups/test1/mon_data/mon_L3_*/mbm_total_bytes
>>      17592178699059  <- Overflow on domain 0
>>      3232332         <- Total bytes on domain 1
>>
>> In this case, the RMID on domain 0 transitions from "Unavailable" state to
>> active state. The hardware sets MSR_IA32_QM_CTR.Unavailable (bit 62) when
>> the counter is read and begins tracking the RMID counting from 0.
>> Subsequent reads succeed but returns a value smaller than the previously
>> saved MSR value (7345357). Consequently, the resctrl's overflow logic is
>> triggered, it compares the previous value (7345357) with the new, smaller
>> value and incorrectly interprets this as a counter overflow, adding a large
>> delta. In reality, this is a false positive: the counter did not overflow
>> but was simply reset when the RMID transitioned from "Unavailable" back to
>> active state.
>>
>> Here is the text from APM [1] available from [2].
>>
>> "In PQOS Version 2.0 or higher, the MBM hardware will set the U bit on the
>> first QM_CTR read when it begins tracking an RMID that it was not
>> previously tracking. The U bit will be zero for all subsequent reads from
>> that RMID while it is still tracked by the hardware. Therefore, a QM_CTR
>> read with the U bit set when that RMID is in use by a processor can be
>> considered 0 when calculating the difference with a subsequent read."
>>
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>>      Publication # 24593 Revision 3.41 section 19.3.3 Monitoring L3 Memory
>>      Bandwidth (MBM).
>>
>> Fixes: 4d05bf71f157d ("x86/resctrl: Introduce AMD QOS feature")
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> Cc: stable@vger.kernel.org # needs adjustments for <= v6.17
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537 # [2]
>> ---
>> v4: Removed switch and replaced with if else in the code. Tested again.
>>      Removed a stray tab in changelog.
>>
>> v3: Rephrasing changelog considering undercounting problem.
>>      Checked again for special charactors (grep -P '[^\t\n\x20-\x7E]').
>>      Removed few of them now. Thanks Reinette.
>>
>> v2: Fixed few systax issues.
>>      Checked for special charachars.
>>      Added Fixes tag.
>>      Added CC to stable kernel.
>>      Rephrased most of the changelog.
>>
>> v1: Tested this on multiple AMD systems, but not on Intel systems.
>>      Need help with that. If everything goes well, this patch needs to go
>>      to all the stable kernels.
> 
> The behavior of the counter is different on Intel where there are enough
> counters backing the RMID and the "Unavailable" bit is not set when counter
> starts counting but instead the counter returns "0". For example, when
> running equivalent of "step 1" on an Intel system it looks like:
> 
> 	# cd /sys/fs/resctrl
> 	# mkdir mon_groups/test1
> 	# echo $$ > mon_groups/test1/tasks
> 	# cat mon_groups/test1/mon_data/*/mbm_total_bytes
> 	0
> 	1835008
> 

Thanks. That is good to know.

> I am not aware of resctrl being able to trigger an Unavailable counter via
> these counter registers on existing Intel hardware and as a consequence do
> not expect this new flow (ret == -EINVAL) to be triggered on Intel. There may
> be some differences with RDT MMIO counters that I need to look into but since
> that is not supported by resctrl yet it is not relevant to this fix.
> 
> Tested-by: Reinette Chatre <reinette.chatre@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> 

Thanks. Much appreciated.
- Babu Moger


