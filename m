Return-Path: <linux-kernel+bounces-725876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61779B004ED
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 16:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDACB3B20EB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0690B2727F1;
	Thu, 10 Jul 2025 14:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="d87LrPNA"
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2130.outbound.protection.outlook.com [40.107.115.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B01271456
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 14:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752157094; cv=fail; b=tbni5E7CIBecOHuj77EZ0Xy/LhRRO7zVbZDILSuh0anZMWxFrcXL/NwmCe+7v1dryauIHacj3iZFX3IoshjyrvbyIj5AQwc3UhBfwE5/r8tc/gjfp525R5r0e+D60QZoPw08WLBNs/ePWyAgqyYL+5xnhuRWvNAe1f+lU5GQF+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752157094; c=relaxed/simple;
	bh=PSVrPpKqBN0XLS8vGbLTg6zOeiiXgVOp2FiivL6kLp4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fw/OL1851LsfZA24CJXlXoFnXgUlVjfBilPb80hKKaYMHAiIJKzAbN51JhIBzr6cJ3w/OCHYp7QUlGOWDujH4xJd2GLmqoBFaZCLUWPFTRQzX7JvIukh0FOLWrwp8ZTFmuvaZUon9cB27Tqp3MWaJnATk3XgoMKSAcq1mdWpICU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=d87LrPNA; arc=fail smtp.client-ip=40.107.115.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vonSOrMWnhi7IQf+R30saXMi7d1LlOBJ06RelQqImeayNcl5YEC6KQsOJjaYyZslAOjGpUa891bsUE+draAKf5xxXm5V1o8Mxe/7bySvTaMr3KZP5JTqn1A14u4GffZmJKj6e8gMFhfHM1mDGoiH+WAgS0HZovVGG6gBhHKCP+ebnGxVKF6S21X1Aqf6UQv+CqVt9JLmxZQ3eTzrXS5YKD0WSbMRSsSa2UMr8bXLf9lKOScnF1LI5lr2HmdGpr9R/Wf1aAxrLNn/AU/Bw/ToxoXI/TN3Z63H7iGB4pR9CsGpAx57hbgsaHlO0QvrlnwH3AdRrxdPL6o/F5RJDTtzlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x//ypNipGWDpdb2appXu9QYAGM2b8qS0QgluytJ+Adw=;
 b=v3VG/9w5DjFV/hvhJdTXBBt4v8UxYtvyqYvx4s0qAScF6G/qyZpvNgJZ5DH1mBtUtctUGhjvPWTgUWl5hcvuAvTt6PId4ZyB2UhCOdunTQlWLXhqWhGx0HuTy2kSYuj9TKOB6R+f7nrj7u5jJae/gYcNovJUVNB1nwVEfWy7jE3fqwsLUhJHlnvtL6VXu9H+EZCumnH8FsUtlS5/4W4LtJBoA+2ZUMGnIdqr1pWJzLDcS3EzkJWwwIR5WEtEGXZDB0W95X7hkKFGD0TPx3jT3zRsTVBUnRW1J9636G/CcYgL5wpB72ay6iimldZiEk7SqgBhU7/dn7PEDq4OFJCGkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x//ypNipGWDpdb2appXu9QYAGM2b8qS0QgluytJ+Adw=;
 b=d87LrPNAMaOusnyKn7FcNCWuoySanlwuSO1fdwtDRObJyYpLP2L/6RgqyjXIHASUrrOQ8FD9Ohmm7K2iI1UJyc/4BFK5zyQyryUSBgExKhZQFi5sd8aKF5r53cVvQ2o1HDbHbjInnpyRMnkh7If9lnouZ7n0IUUH82uuHXuUVrcQBLuu+JgGGWXUCCRj1Lm8Y4S/cLl6jAu/Eam1UxJl9dYQz92i18lA7e2rGY/QGxzOrNNIO9qAaIUdL/b0YnCO+CHtzKTglN9WQGG/qAbXs6uX/Nj50Kz3C0rkVMXg7QV2lwRDNIltXG8qEci6Sl0qPoAcuQ0oXuiQT5n45VfChg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT3PR01MB6299.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:66::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Thu, 10 Jul
 2025 14:18:09 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 14:18:09 +0000
Message-ID: <23a82166-820b-4baa-90ee-2d6d1de4f4d3@efficios.com>
Date: Thu, 10 Jul 2025 10:18:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 2/3] sched: Move task_mm_cid_work to mm timer
To: Gabriele Monaco <gmonaco@redhat.com>,
 kernel test robot <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, aubrey.li@linux.intel.com,
 yu.c.chen@intel.com, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Ingo Molnar <mingo@redhat.org>
References: <202507100606.90787fe6-lkp@intel.com>
 <d8eacb24-af73-4580-8248-1fd1ac33e28f@efficios.com>
 <fa7a3ea2c6326639911fbe49b86975f79db92372.camel@redhat.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <fa7a3ea2c6326639911fbe49b86975f79db92372.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBP288CA0006.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::16) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT3PR01MB6299:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f05d0d1-5f9c-4d26-5303-08ddbfbc9873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVZnNmNoSDE4bXRVVjQ2cmtxcVk0MUJWZFZLMk1XNmFBcm1SSEtDMTNvYkJ0?=
 =?utf-8?B?MXcwNG9zNmpMTnhMMVNIYnc4cHhLT3A4Ylg2QzJpeHRGUXJoZTlPUlBvMDFn?=
 =?utf-8?B?cE9QZ0VrYnpjUXFsTTlqK0ZmRm5lempscXBQVytaSDl5SHE2MCtyQ3doWmJ4?=
 =?utf-8?B?Q2hLNDl4akhsNGJ3Vmh4eFV3NVphZHFEaTdWYVd1cXl0aGFCWm5EeDJzK1BT?=
 =?utf-8?B?K0g2WDFVdnYzWS9tVGt5TEphNGRSZVRBYXF6QnYyeURSaFVRQ1NRSVdsdTh6?=
 =?utf-8?B?aUJSRjFWTkpxVks0V3JMREQycFVXQytGV3NpSjdJaFB2alp5b1lOOHN0blNp?=
 =?utf-8?B?aEdvKzMzbnJpNTNuaEJJczJnajRyUzMyOEFLWWhyYll3MHZmNU45MEVTNlBs?=
 =?utf-8?B?NndkTjNMVHc2K0lXOWV6TWVJdUk0ejc0WEcwZG54R2lwc1lEcnNsY001RHV3?=
 =?utf-8?B?OFE5bHA5WEZ0eFVJSnY3UVlzeHhtcEhIOUt4M1QyY1BMdVdWdjhHWlZGL1hO?=
 =?utf-8?B?ZWhoRSt1NFNzK1JMYlNWbFZjbk9VVUpaZlpUVHplQWpjSVIvc2tzUEY2RWQ2?=
 =?utf-8?B?dDJFM0lRWk9vQjdZc2tJd1ZCYnlteGVFb3JQNFdWYVdGYlptN3dVcDFMbVVh?=
 =?utf-8?B?YTZyczBiOC9jNnVtdkxJcnpCcXVrdWtJOUJrZThCUm5rQUx1SU9ReXVMRkhE?=
 =?utf-8?B?VU95TFN5b0tqSDViZWlqVVd5T0ZNT2lnd09Gak5iSHdRSTBCR0VUK1JhY1Ji?=
 =?utf-8?B?bHV6QkZJZDZ1Z1EyUUI4Q1c0dkd2c2F3NXVaYXFWb2Z6Y0hLTVVadkdwNjhq?=
 =?utf-8?B?dnJ5RDhYaGRUZFZhcncrbnBwK0JSM3BTaG4vc01zeml1MGpHZXJXaTgydDZK?=
 =?utf-8?B?enNqbDNzWUlrN1RVWmRFdG54SVRFVWNXdGI2UDBWSWxlTWx5MmlLNVpscFQv?=
 =?utf-8?B?eXIrSE1DcWMrMVh2VXNqdmxzcDJQdkFEbUNaRXUxcE5CTk5BQWlVVjFpcUVt?=
 =?utf-8?B?QThnQW9vMnI5QlNrMGxrbmRucFdYemJZNE1zWnhRMUQwMkhwUW05eTN0UG9s?=
 =?utf-8?B?emFuMkN4YTBrSjRMRVZiYlRXTHVCbmQxemFraldZNWxGaWJ5Q2JaTEM0Zk5x?=
 =?utf-8?B?aEVrSnlzQURiUEtnaHEzamk2V2U2a2dyTDc4V0xqNjQ1Sm15UGRIL3dDeCtq?=
 =?utf-8?B?NzBwZ2phYUF0NkllRk9xdEhjeFExQ3o1RncwdVkxTzBDMU9iQVZzY3JHT3VV?=
 =?utf-8?B?bEd6MmNwczQ3Wmt3bi93bWZUYmxRNHdRMjdRZ0RER0ljaWF5TjV5aG5jMGR4?=
 =?utf-8?B?bDFWSmU0T2lPUkVjNXJLWDhMSldFQzdjSlI0SUMyNHd5dFk5dTBFZnN5SmJW?=
 =?utf-8?B?MlJaVWtHL2ZPNGZPWGIwMW95ZGFUa0ZRV0VBck9mK3VWbTRxN0h6b3Z1Tzl0?=
 =?utf-8?B?UzRxWGFpMzBJSnVIM2NkNlRqUG41a2hWMUhUeWwzL09pSUp0Vy91VE9VMzZ5?=
 =?utf-8?B?aEVqUkpOTWhOck5oUzJiTjNyS1B6aVBoT29TWGN1dFdtb05sVE1TLy9UdWJ0?=
 =?utf-8?B?V29XYkxMdDVoaUlobHNKMEZzSENmMHIvZU84MGNod0swbCthZlQrTkYrSU9m?=
 =?utf-8?B?aTkzbGVieW02N1BRaGVoS1pVVnZ2aGJ4OTRsYjVXajhnUVJKQXdBTXRpVHQ3?=
 =?utf-8?B?d1o2RFJJNVpSUXkvU200dkxFMDVDd3g1anJFRkFoZmpnNGxDbWVndDdsU01P?=
 =?utf-8?B?eEx4K1pONW1jOFM2SzdEMGt0ZDdHbG40MnhRMUt0alJsa3p4N3IzbWp6Q2Jl?=
 =?utf-8?Q?bUFqPvOaYN+5mJUJ4y2CSk/7AhbXchf+ObFj8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ejNIYzF0dmo5Skp2RURWaXFoSkNlcVZOd1J6M0pxbHl6RnFxZk5DQVR3Sm1z?=
 =?utf-8?B?c1BqYk9ISVNLaG5mR1d3MituaVhiVWJCMnFZOTVlNGN2SnRwTlNUNVhhcXRo?=
 =?utf-8?B?anhRK09Lb0RKR3hhWC91OGlZZ1BTWkYxaEh0RVY0dDllMlB0UzFObWx2aHJC?=
 =?utf-8?B?VS92czZEUFlGQlBSNnBhK0w5ZjBlc3pNTCtBRWlFSDJKTUlacUlkYi8vSlQx?=
 =?utf-8?B?T1QzaTVNTUVrQkNicm9KOFZsZWJMamxHZHlzRWcwMGV2Zjd4VElkVVE5aFFa?=
 =?utf-8?B?RmRiSHc2eExuMzJHT2JQUmtQK1FKOUR4YWJvSkNvRSs3c2hPSEhLVlVRam9E?=
 =?utf-8?B?WEUzeHBSU0d4VUZHVU80UWN4TGNuNFpEeUdqZnNuRnlPVG9yVUNSRnNnOXJQ?=
 =?utf-8?B?cWlxQkYwWHYxNktXWlFITFdyaHBCZTh6OWR5MDc2M2VJSXY2cGp6ek50M014?=
 =?utf-8?B?bm4xWlM2a1E2cGJMUjZFQUN5UmV4SVFDdTltd3B6OHpBdFlqa3FVRnZpMGlO?=
 =?utf-8?B?bGFDU3Nhd2t0ZWd1bXBra21DNnpFS3EwSmZtc0xXMHk2cEh3a3lFUXB1dktW?=
 =?utf-8?B?SzZTU0FrM3l3ODJkYzQxMzE1K0tGZWlhWG5JaTFoQ2g0dHdmUDgxN1RpZWV5?=
 =?utf-8?B?anV6SWxhbTFqTTRTMGZUcUE5VGVOKzVKU2lERDc4T1FsL01sbW83cmt2NFdR?=
 =?utf-8?B?L3lHYTI4NUU1QlRJUnM3Y1ZEekFzRmRjT2FWaVRzOUtMRXA2L004OXJKUG1P?=
 =?utf-8?B?bXVZREJpRFN5ZmIyd0VuSTMwRVVvT1A0ZTNFdHJucXVkbm5TL015S2ZpcktF?=
 =?utf-8?B?ZE13QVFxQzdLV3YrL3FUYzd1R1kzWUFIa1dDdTFPMnVIdjRyQVhTa3RiR3BR?=
 =?utf-8?B?bGJxd0VxV3pZOHcyN3dOT1h6RWxMRGxSMS9uWmNKSC80ZEU0YXBjcTB6R3NB?=
 =?utf-8?B?WmlEVTl3d2FORHoxL1ZFOUFLZG9tMmZJN0VnclhZdWNPWGhtUFBWREJOYjQ4?=
 =?utf-8?B?Ymg0T3NYQmFKeTdBMHlnT1VFekNFYzM3a0wvWmhmVkFkOHlobk1UTWVDOE5N?=
 =?utf-8?B?aVBrUGVLMU5ydStGaEw5eFI4M0l3V3dTeGlXUk53SXpKU0t6ZzY3YlJrVm5M?=
 =?utf-8?B?RHNxbUIwZHkyR2JIbHgyOUlGdGxzVEpqelVIcFNPaU5wUzEwZ0FBRWh4UnlG?=
 =?utf-8?B?RVE2Y1hLZWJhbWV0a25FNFVwWGp6K1U1RUhxYTV5WUV6bjR0K3c4UVppM2tI?=
 =?utf-8?B?aDlVbERObHNLNCtSTm5wMFFTV1F3Z1dNZzlsdlZuWmhrUUhWeUlwc0xqSFdJ?=
 =?utf-8?B?TFZjeTZ1NmhWRFpVSUlaRElQL3c2R2FFOThhcEFIS0szT3A5U2JxRXBneGxs?=
 =?utf-8?B?anFFTDF5Rkh5Yy8xWlp2Lzg4YkJPbFlRdTZ4V1N5TWQxRXQyYU9DNElQaElr?=
 =?utf-8?B?cC9hbXRGSWsrTWtId2hzc0JlT2d2Ri9qT2ZDOForcm13MHY0c2RLZU56Q0Np?=
 =?utf-8?B?U3BFZjB2d21zNkExUmtocGpiaE05MlRyR1hNWGVrOFA3b0I1NjdMcmtOa0R0?=
 =?utf-8?B?ZFNEdU9RR3dpZVVuaXhuNjRpMUFZYVlVMFR4K3BzdkpCRGpxTlJGSjRmOTdw?=
 =?utf-8?B?c3BIUVpSVWU5a3lZSDJmRkNBcnYzaWxkQjV3ZFRtTStFdU9hNUgyYWVTZ05W?=
 =?utf-8?B?ek5FWEM1T1dHWTJ4Wnp5NWFzTWRIT0Rlem5SSTBjMHlBdWp0NDVQcUNxN0pC?=
 =?utf-8?B?YnMyVGFwalNWTVZBMWtJL1l3T0ZoY2E3UnJpL3RFemtTM0pFem0wTGduc3R4?=
 =?utf-8?B?ZTcrYlREWGFzN0xCWmtJR0pwS0xockpmcHQ5dU5SOVd0OEdMM3djaEVVN3BN?=
 =?utf-8?B?WHE3dlBkZ3YwUThaT1pKWFB6aG9xOVV6UFMxaTQ4dHFWTzJvUUlwUEZod2Np?=
 =?utf-8?B?QlR3aWoyS0VwOHRQSzZ1WDF1bUc5MVZ0QWh5Yjh1TENYS1dCeUVENG9kQWt5?=
 =?utf-8?B?TEY4UENlcWUvWWNtSkFIOGREV3RNd1gyQzdlV28vY0MwR0JLSmxmRC91NEpw?=
 =?utf-8?B?UlFVMGVFVHVaZ3IwWTZDMXcwNW1uVHRDOWlTSWh2Z21ER0NiMGRBNUkxSER4?=
 =?utf-8?B?U2s1YXo1K1F4ckQ2L1dmVndYYVhWWEFNTTRyajl5RTRqU05DeTRLa0ZiWGpQ?=
 =?utf-8?Q?BrVANHnVO9tvdylU3MfOgAk=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f05d0d1-5f9c-4d26-5303-08ddbfbc9873
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 14:18:09.0059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YdoQUVImCH8BLthE6ZA7pLzm+rQiTzJ/qzP11rkytoFpow/4zbj+P9lWQYSsNm9kCTGks0G7gPXA4eFU2tw5vnFTucIeFR18W58l1Z4zHVw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB6299

On 2025-07-10 09:40, Gabriele Monaco wrote:
> 
> 
> On Thu, 2025-07-10 at 09:23 -0400, Mathieu Desnoyers wrote:
>> On 2025-07-10 00:56, kernel test robot wrote:
>>>
>>>
>>> Hello,
>>>
>>> kernel test robot noticed "WARNING:inconsistent_lock_state" on:
>>>
>>> commit: d06e66c6025e44136e6715d24c23fb821a415577 ("[PATCH v14 2/3]
>>> sched: Move task_mm_cid_work to mm timer")
>>> url:
>>> https://github.com/intel-lab-lkp/linux/commits/Gabriele-Monaco/sched-Add-prev_sum_exec_runtime-support-for-RT-DL-and-SCX-classes/20250707-224959
>>> patch link:
>>> https://lore.kernel.org/all/20250707144824.117014-3-gmonaco@redhat.com/
>>> patch subject: [PATCH v14 2/3] sched: Move task_mm_cid_work to mm
>>> timer
>>>
>>> in testcase: boot
>>>
>>> config: x86_64-randconfig-003-20250708
>>> compiler: gcc-11
>>> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp
>>> 2 -m 16G
>>>
>>> (please refer to attached dmesg/kmsg for entire log/backtrace)
>>>
>>>
>>> +-------------------------------------------------+------------+---
>>> ---------+
>>>>                                                  | 50c1dc07ee |
>>>> d06e66c602 |
>>> +-------------------------------------------------+------------+---
>>> ---------+
>>>> WARNING:inconsistent_lock_state                 | 0          |
>>>> 12         |
>>>> inconsistent{SOFTIRQ-ON-W}->{IN-SOFTIRQ-W}usage | 0          |
>>>> 12         |
>>> +-------------------------------------------------+------------+---
>>> ---------+
>>>
>>
>> I suspect the issue comes from calling mmdrop(mm) from timer context
>> in a scenario
>> where the mm_count can drop to 0.
>>
>> This causes calls to pgd_free() and such to take the pgd_lock in
>> softirq
>> context, when in other cases it's taken with softirqs enabled.
>>
>> See "mmdrop_sched()" for RT. I think we need something similar for
>> the
>> non-RT case, e.g. a:
>>
>> static inline void __mmdrop_delayed(struct rcu_head *rhp)
>> {
>>           struct mm_struct *mm = container_of(rhp, struct mm_struct,
>> delayed_drop);
>>
>>           __mmdrop(mm);
>> }
>>
>> static inline void mmdrop_timer(struct mm_struct *mm)
>> {
>>           /* Provides a full memory barrier. See mmdrop() */
>>           if (atomic_dec_and_test(&mm->mm_count))
>>                   call_rcu(&mm->delayed_drop, __mmdrop_delayed);
>> }
>>
>> Thoughts ?
>>
> 
> Thanks for the suggestion.
> 
> I noticed the problem is in the mmdrop over there, but I'm seeing this
> is getting unnecessarily complicated.
> I'm not sure it's worth going down this path, also considering pushing
> the timer wheel like this might end up in unintended effects like it
> happened with the workqueue.
> 
> I am going to try the alternative approach of running the scan in
> batches [1] still using a task_work but triggering it from
> __rseq_handle_notify_resume like here.
> If that works in the original usecase, I guess it's better to keep it
> that way.
> 
> What do you think?

Yes, I think the batching approach makes sense considering the overhead
of worker threads when used periodically at 100ms intervals, the
complexity that arises from doing mmdrop() from timer context, and also
the fact that doing task_mm_cid_scan (iteration on all possible cpus)
from timer context may introduce latency on configurations that
implement timers with softirqs.

It will delay how much time it takes for cid compaction to react to
threads exiting though (wrt selftests/rseq: Add test for mm_cid
compaction). We will probably want to update this test to take into
account that the time it takes for compaction to complete depends on
the number of possible cpus.

Thanks,

Mathieu

> 
> Thanks,
> Gabriele
> 
> [1] -
> https://lore.kernel.org/lkml/20250217112317.258716-1-gmonaco@redhat.com
> 
>> Thanks,
>>
>> Mathieu
>>
>>>
>>> If you fix the issue in a separate patch/commit (i.e. not just a
>>> new version of
>>> the same patch/commit), kindly add following tags
>>>> Reported-by: kernel test robot <oliver.sang@intel.com>
>>>> Closes:
>>>> https://lore.kernel.org/oe-lkp/202507100606.90787fe6-lkp@intel.com
>>>
>>>
>>> [   26.556715][    C0] WARNING: inconsistent lock state
>>> [   26.557127][    C0] 6.16.0-rc5-00002-gd06e66c6025e #1 Tainted:
>>> G                T
>>> [   26.557730][    C0] --------------------------------
>>> [   26.558133][    C0] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-
>>> W} usage.
>>> [   26.558662][    C0] stdbuf/386 [HC0[0]:SC1[1]:HE1:SE0] takes:
>>> [ 26.559118][ C0] ffffffff870d4438 (pgd_lock){+.?.}-{3:3}, at:
>>> pgd_free (arch/x86/mm/pgtable.c:67 arch/x86/mm/pgtable.c:98
>>> arch/x86/mm/pgtable.c:379)
>>> [   26.559786][    C0] {SOFTIRQ-ON-W} state was registered at:
>>> [ 26.560232][ C0] mark_usage (kernel/locking/lockdep.c:4669)
>>> [ 26.560561][ C0] __lock_acquire (kernel/locking/lockdep.c:5194)
>>> [ 26.560929][ C0] lock_acquire (kernel/locking/lockdep.c:473
>>> kernel/locking/lockdep.c:5873)
>>> [ 26.561267][ C0] _raw_spin_lock
>>> (include/linux/spinlock_api_smp.h:134
>>> kernel/locking/spinlock.c:154)
>>> [ 26.561617][ C0] pgd_alloc (arch/x86/mm/pgtable.c:86
>>> arch/x86/mm/pgtable.c:353)
>>> [ 26.561950][ C0] mm_init+0x64f/0xbfb
>>> [ 26.562342][ C0] mm_alloc (kernel/fork.c:1109)
>>> [ 26.562655][ C0] dma_resv_lockdep (drivers/dma-buf/dma-resv.c:784)
>>> [ 26.563020][ C0] do_one_initcall (init/main.c:1274)
>>> [ 26.563389][ C0] do_initcalls (init/main.c:1335 init/main.c:1352)
>>> [ 26.563744][ C0] kernel_init_freeable (init/main.c:1588)
>>> [ 26.564144][ C0] kernel_init (init/main.c:1476)
>>> [ 26.564402][ C0] ret_from_fork (arch/x86/kernel/process.c:154)
>>> [ 26.564633][ C0] ret_from_fork_asm (arch/x86/entry/entry_64.S:258)
>>> [   26.564871][    C0] irq event stamp: 4774
>>> [ 26.565070][ C0] hardirqs last enabled at (4774):
>>> _raw_spin_unlock_irq (arch/x86/include/asm/irqflags.h:42
>>> arch/x86/include/asm/irqflags.h:119
>>> include/linux/spinlock_api_smp.h:159 kernel/locking/spinlock.c:202)
>>> [ 26.565526][ C0] hardirqs last disabled at (4773):
>>> _raw_spin_lock_irq (arch/x86/include/asm/preempt.h:80
>>> include/linux/spinlock_api_smp.h:118 kernel/locking/spinlock.c:170)
>>> [ 26.565971][ C0] softirqs last enabled at (4256): local_bh_enable
>>> (include/linux/bottom_half.h:33)
>>> [ 26.566408][ C0] softirqs last disabled at (4771): __do_softirq
>>> (kernel/softirq.c:614)
>>> [   26.566823][    C0]
>>> [   26.566823][    C0] other info that might help us debug this:
>>> [   26.567198][    C0]  Possible unsafe locking scenario:
>>> [   26.567198][    C0]
>>> [   26.567548][    C0]        CPU0
>>> [   26.567709][    C0]        ----
>>> [   26.567869][    C0]   lock(pgd_lock);
>>> [   26.568060][    C0]   <Interrupt>
>>> [   26.568255][    C0]     lock(pgd_lock);
>>> [   26.568452][    C0]
>>> [   26.568452][    C0]  *** DEADLOCK ***
>>> [   26.568452][    C0]
>>> [   26.568830][    C0] 3 locks held by stdbuf/386:
>>> [ 26.569056][ C0] #0: ffff888170d5c1a8 (&sb->s_type-
>>>> i_mutex_key){++++}-{4:4}, at: lookup_slow (fs/namei.c:1834)
>>> [ 26.569535][ C0] #1: ffff888170cf5850 (&lockref->lock){+.+.}-
>>> {3:3}, at: d_alloc (include/linux/dcache.h:319 fs/dcache.c:1777)
>>> [ 26.569961][ C0] #2: ffffc90000007d40 ((&mm->cid_timer)){+.-.}-
>>> {0:0}, at: call_timer_fn (kernel/time/timer.c:1744)
>>> [   26.570421][    C0]
>>> [   26.570421][    C0] stack backtrace:
>>> [   26.570704][    C0] CPU: 0 UID: 0 PID: 386 Comm: stdbuf Tainted:
>>> G                T   6.16.0-rc5-00002-gd06e66c6025e #1
>>> PREEMPT(voluntary)  39c5cbdaf5b4eb171776daa7d42daa95c0766676
>>> [   26.570716][    C0] Tainted: [T]=RANDSTRUCT
>>> [   26.570719][    C0] Call Trace:
>>> [   26.570723][    C0]  <IRQ>
>>> [ 26.570727][ C0] dump_stack_lvl (lib/dump_stack.c:122
>>> (discriminator 4))
>>> [ 26.570735][ C0] dump_stack (lib/dump_stack.c:130)
>>> [ 26.570740][ C0] print_usage_bug (kernel/locking/lockdep.c:4047)
>>> [ 26.570748][ C0] valid_state (kernel/locking/lockdep.c:4060)
>>> [ 26.570755][ C0] mark_lock_irq (kernel/locking/lockdep.c:4270)
>>> [ 26.570762][ C0] ? save_trace (kernel/locking/lockdep.c:592)
>>> [ 26.570773][ C0] ? mark_lock (kernel/locking/lockdep.c:4728
>>> (discriminator 3))
>>> [ 26.570780][ C0] mark_lock (kernel/locking/lockdep.c:4756)
>>> [ 26.570787][ C0] mark_usage (kernel/locking/lockdep.c:4645)
>>> [ 26.570796][ C0] __lock_acquire (kernel/locking/lockdep.c:5194)
>>> [ 26.570804][ C0] lock_acquire (kernel/locking/lockdep.c:473
>>> kernel/locking/lockdep.c:5873)
>>> [ 26.570811][ C0] ? pgd_free (arch/x86/mm/pgtable.c:67
>>> arch/x86/mm/pgtable.c:98 arch/x86/mm/pgtable.c:379)
>>> [ 26.570822][ C0] ? validate_chain (kernel/locking/lockdep.c:3826
>>> kernel/locking/lockdep.c:3879)
>>> [ 26.570828][ C0] ? wake_up_new_task (kernel/sched/core.c:10597)
>>> [ 26.570839][ C0] _raw_spin_lock
>>> (include/linux/spinlock_api_smp.h:134
>>> kernel/locking/spinlock.c:154)
>>> [ 26.570845][ C0] ? pgd_free (arch/x86/mm/pgtable.c:67
>>> arch/x86/mm/pgtable.c:98 arch/x86/mm/pgtable.c:379)
>>> [ 26.570854][ C0] pgd_free (arch/x86/mm/pgtable.c:67
>>> arch/x86/mm/pgtable.c:98 arch/x86/mm/pgtable.c:379)
>>> [ 26.570863][ C0] ? wake_up_new_task (kernel/sched/core.c:10597)
>>> [ 26.570873][ C0] __mmdrop (kernel/fork.c:681)
>>> [ 26.570882][ C0] ? wake_up_new_task (kernel/sched/core.c:10597)
>>> [ 26.570891][ C0] mmdrop (include/linux/sched/mm.h:55)
>>> [ 26.570901][ C0] task_mm_cid_scan (kernel/sched/core.c:10619
>>> (discriminator 3))
>>> [ 26.570910][ C0] ? lock_is_held (include/linux/lockdep.h:249)
>>> [ 26.570918][ C0] ? wake_up_new_task (kernel/sched/core.c:10597)
>>> [ 26.570928][ C0] call_timer_fn (arch/x86/include/asm/atomic.h:23
>>> include/linux/atomic/atomic-arch-fallback.h:457
>>> include/linux/jump_label.h:262 include/trace/events/timer.h:127
>>> kernel/time/timer.c:1748)
>>> [ 26.570935][ C0] ? trace_timer_base_idle
>>> (kernel/time/timer.c:1724)
>>> [ 26.570943][ C0] ? wake_up_new_task (kernel/sched/core.c:10597)
>>> [ 26.570953][ C0] ? wake_up_new_task (kernel/sched/core.c:10597)
>>> [ 26.570962][ C0] __run_timers (kernel/time/timer.c:1799
>>> kernel/time/timer.c:2372)
>>> [ 26.570970][ C0] ? add_timer_global (kernel/time/timer.c:2343)
>>> [ 26.570977][ C0] ? __kasan_check_write (mm/kasan/shadow.c:38)
>>> [ 26.570988][ C0] ? do_raw_spin_lock
>>> (arch/x86/include/asm/atomic.h:107 include/linux/atomic/atomic-
>>> arch-fallback.h:2170 include/linux/atomic/atomic-
>>> instrumented.h:1302 include/asm-generic/qspinlock.h:111
>>> kernel/locking/spinlock_debug.c:116)
>>> [ 26.570996][ C0] ? __raw_spin_lock_init
>>> (kernel/locking/spinlock_debug.c:114)
>>> [ 26.571006][ C0] __run_timer_base (kernel/time/timer.c:2385)
>>> [ 26.571014][ C0] run_timer_base (kernel/time/timer.c:2394)
>>> [ 26.571021][ C0] run_timer_softirq
>>> (arch/x86/include/asm/atomic.h:23 include/linux/atomic/atomic-arch-
>>> fallback.h:457 include/linux/jump_label.h:262
>>> kernel/time/timer.c:342 kernel/time/timer.c:2406)
>>> [ 26.571028][ C0] handle_softirqs (arch/x86/include/asm/atomic.h:23
>>> include/linux/atomic/atomic-arch-fallback.h:457
>>> include/linux/jump_label.h:262 include/trace/events/irq.h:142
>>> kernel/softirq.c:580)
>>> [ 26.571039][ C0] __do_softirq (kernel/softirq.c:614)
>>> [ 26.571046][ C0] __irq_exit_rcu (kernel/softirq.c:453
>>> kernel/softirq.c:680)
>>> [ 26.571055][ C0] irq_exit_rcu (kernel/softirq.c:698)
>>> [ 26.571064][ C0] sysvec_apic_timer_interrupt
>>> (arch/x86/kernel/apic/apic.c:1050 arch/x86/kernel/apic/apic.c:1050)
>>> [   26.571076][    C0]  </IRQ>
>>> [   26.571078][    C0]  <TASK>
>>> [ 26.571081][ C0] asm_sysvec_apic_timer_interrupt
>>> (arch/x86/include/asm/idtentry.h:574)
>>> [ 26.571088][ C0] RIP: 0010:d_alloc (fs/dcache.c:1778)
>>> [ 26.571100][ C0] Code: 8d 7c 24 50 b8 ff ff 37 00 ff 83 f8 00 00
>>> 00 48 89 fa 48 c1 e0 2a 48 c1 ea 03 80 3c 02 00 74 05 e8 5f f3 f6
>>> ff 49 89 5c 24 50 <49> 8d bc 24 10 01 00 00 48 8d b3 20 01 00 00 e8
>>> 87 bc ff ff 4c 89
>>> All code
>>> ========
>>>      0:	8d 7c 24 50          	lea    0x50(%rsp),%edi
>>>      4:	b8 ff ff 37 00       	mov    $0x37ffff,%eax
>>>      9:	ff 83 f8 00 00 00    	incl   0xf8(%rbx)
>>>      f:	48 89 fa             	mov    %rdi,%rdx
>>>     12:	48 c1 e0 2a          	shl    $0x2a,%rax
>>>     16:	48 c1 ea 03          	shr    $0x3,%rdx
>>>     1a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
>>>     1e:	74 05                	je     0x25
>>>     20:	e8 5f f3 f6 ff       	call   0xfffffffffff6f384
>>>     25:	49 89 5c 24 50       	mov    %rbx,0x50(%r12)
>>>     2a:*	49 8d bc 24 10 01 00 	lea
>>> 0x110(%r12),%rdi		<-- trapping instruction
>>>     31:	00
>>>     32:	48 8d b3 20 01 00 00 	lea    0x120(%rbx),%rsi
>>>     39:	e8 87 bc ff ff       	call   0xffffffffffffbcc5
>>>     3e:	4c                   	rex.WR
>>>     3f:	89                   	.byte 0x89
>>>
>>> Code starting with the faulting instruction
>>> ===========================================
>>>      0:	49 8d bc 24 10 01 00 	lea    0x110(%r12),%rdi
>>>      7:	00
>>>      8:	48 8d b3 20 01 00 00 	lea    0x120(%rbx),%rsi
>>>      f:	e8 87 bc ff ff       	call   0xffffffffffffbc9b
>>>     14:	4c                   	rex.WR
>>>     15:	89                   	.byte 0x89
>>>
>>>
>>> The kernel config and materials to reproduce are available at:
>>> https://download.01.org/0day-ci/archive/20250710/202507100606.90787fe6-lkp@intel.com
>>>
>>>
>>>
>>
> 


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

