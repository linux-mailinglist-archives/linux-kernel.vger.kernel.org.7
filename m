Return-Path: <linux-kernel+bounces-720102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB036AFB71E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 17:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 333F417743F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 15:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14782E2F0D;
	Mon,  7 Jul 2025 15:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="epX9vwi5"
Received: from CAN01-YT3-obe.outbound.protection.outlook.com (mail-yt3can01on2095.outbound.protection.outlook.com [40.107.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D9429E0F1
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.115.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751901575; cv=fail; b=KBj7eEfOlevTEW3acmYjzUp4fT1rIbkpxbTuyMc+o5+LRFoYVITH/jv5o4yNZDvwtsMVtGX6h1DmXURPKyXaFw5fmSswnz0IFum73+xDnRZbdGyjDkyzRWEu/e7QRhBipCd61inXzvchB4F8V5fFpG5QxKwbx7Q2uNO4s1JcQ/M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751901575; c=relaxed/simple;
	bh=fgXpRJbLP11twU6BbZk4PFMHiSsiwRsJEbyeNEY5jjw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U5sYiYDdpLx6AgAH2jhzCYsGSIWesZKvpvwfHFhpi3HL9BDsV2+GxSP53eS349/jnAcC3ZcqcWgqgvFoDzkFo7c9VA4vpKqhGn+Yq0tQVec8flV0DXx9tEdMKZ8XfvYdq7otlEcjG14Vg557ZrNcAGjVrUhuSa7UtZ0Fh25Kdcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=epX9vwi5; arc=fail smtp.client-ip=40.107.115.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHK2Xica9xFFlbQLwuX/qz6Hp3tC2gQf3BSxzDY99kqezV92MoMW9IjDnS2PrG+oI5s4k5buZ/FI0MGBbAuCIk/GZqZ9FXWzw4E/jhm34chMSrSghmtZUguW3+ZkCB/4taf5L+O6/ng6fNIsOAElHb5BZCQeyLIholCllyw1OGYH+4zQ/oI30rqkK9PBQ+vM7qskta5YYMs3gmMlpx649mGfsbnJUZLRksFgbULDTJCmrDjrA1l8RJXka0perIpIHrrvtBAqITfjtam/R/dtx9VKpgeb9MMZoyuCAVDZT+G13/0sgakquuRWT9MTl1SIs2j8F0UytvmxObX+MnFK0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KYAPxftiQYtLAo9dIW3soQqsRpjs96NObUU9uaUyOMk=;
 b=qCW0jspA8qUUe8vS7AaIKyo+qAIdcvTfL7mtnmWEFxypu/aJnK/SL7PYXpd8HPSukv2Y46Hx+MhWArj36E5QL2OzFMecjuHtc9oR/JbF6r1382yZyv3lVFqBLI7G4b5tQcSkTcflt+MD7uPQ3KJr5uS5nweOwQMHyjnZgT8sxbDtF8gT73/J+PtCsCsO0AsoTEMwyxprpOGs1xvPeQs0sgh0mscmNLKm6HH2oKCZwHs7hj1Zd9dS/uyhzenqr0sISvVWXM9HEHo11gRl+QkbVUisSEh/NefVxUNsdqIG5rBIzT8mGE8evGxMrBgYyimV0MMF5U56XSK1qUVVOdi1lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYAPxftiQYtLAo9dIW3soQqsRpjs96NObUU9uaUyOMk=;
 b=epX9vwi56pkTLeE9TZ7o9So8zSFhc0ePBgsOwh8ho3ZsoxiGJbpHke2dum/60UqyXYmoOMEK3ICczFHHNLMwgZbtQDTdIn3ZV7MP0/s5ngk2aPltiZITEUx0bW/HkjKhplu45smN9yBz6oyPxaUjzeZ7GyNJi9BkLatcAYQVDYZaB1Xe6mdCbayrsbmDHx0C8e0M4xUqLgxZRcHYpuf1W44kYTJgIfU2pt/ZIA3O28aVqbawCVD5c1sLc8BzfQY4JHW20lvFNyTvNizlPMZrA99fdw361h5RBvk/Sb1U2G6B0LjPrLZ7lmVLSfDbqvL441z9IjlEHyxBEYQsWFDu1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB9200.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:5f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Mon, 7 Jul
 2025 15:19:27 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%3]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 15:19:26 +0000
Message-ID: <f83ff5f1-596e-4a94-8a87-4941bb1c431e@efficios.com>
Date: Mon, 7 Jul 2025 11:19:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 2/3] sched: Move task_mm_cid_work to mm timer
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, linux-mm@kvack.org
Cc: Ingo Molnar <mingo@redhat.org>
References: <20250707144824.117014-1-gmonaco@redhat.com>
 <20250707144824.117014-3-gmonaco@redhat.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20250707144824.117014-3-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:15::17) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB9200:EE_
X-MS-Office365-Filtering-Correlation-Id: ac5b8e34-6005-432c-d963-08ddbd69a94a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUpocENrd0RQVmdkU3l3bUl0K3hTRE5KUkdsNUFZaHpadHlUVEtzS2VtVnlF?=
 =?utf-8?B?YnFNaW1tRjAxOW04OVpIM0N3NUkrSnhjV0o4SkVlVEp5WFRjckR3dEE0MGtw?=
 =?utf-8?B?bTZhQ2dvUkoyTEhoZFNpRWJ3RCtDMkJCTE9NMDVCVGNWTlk2a2U5VlRKdnUw?=
 =?utf-8?B?dDUxWkovcWIrSE1MWFZKbjN1Zi9NQ2hQRFhEUWpxS2NERDBDYjRzRy9TamZH?=
 =?utf-8?B?TlB5OTRDeDhjdTgyVTdGajF3T2lFQU9XQ0t3dUVMYjRRa3VNa1RKZVlpOVlN?=
 =?utf-8?B?YkhtWlBKSFJLei95aGZWZWxEb3k2VUx0N3ozV3VLSTY3bU1YUUVjczg5cWtG?=
 =?utf-8?B?aThBWGY3SkRLd1BjM0FQbjVZTXBoVWp0Q3dCVmh3cVZmM0c4ZVdZVitzUDkw?=
 =?utf-8?B?YzJ5U3d1L0hQRHlQa0E4dmJWbk5tdDB6Skwwd0NYcHF6N3dyOXJwbFJpOGVh?=
 =?utf-8?B?MGI4S3JwVkFuTGV3ckdNUG13bk9Xd3p5MlZTWWljNzBZUnVvMXoveHJYZVNQ?=
 =?utf-8?B?N1B2cDM5MVZoUlBYUlFNakZqa3Z2Q3l6dUNBTDRwNHlPTnUzcU5CdTVaeHp6?=
 =?utf-8?B?bUlIbzhRbWNoMjVBN2VBT1dHSlp3YVJMK0ZISDFNNDBpZjFzcGg0UUFqNFhU?=
 =?utf-8?B?eE1ySHUrZW9XYXZzNDloOXcyR3doNkh2Sm1DQmZFMElBQU00M2RESGpxVVEz?=
 =?utf-8?B?OHZYWjRNRjJWRDJubnFkcE1NRUxGblp6Uzg5aDlacmhPaGJBSzFXMnlZbS9t?=
 =?utf-8?B?MERKVmZHeU1TZzBLMzJEN2JIekJWYXFMdUFUVEEwdjg1L1ZndEM5cHZwVlFi?=
 =?utf-8?B?aGkwc2JNNHgrQkVVQWFFRzhNTFRzYjdrdXphejEyUUlubW5NSzFJSElMNkZ4?=
 =?utf-8?B?bDJFQ1RkdStja2VoTWZLdDdOaTlnU3J4VmgvMC9CZW9EcjVVQ2tPUmRKK0xs?=
 =?utf-8?B?bFhjZHVUM2FzMFp3ZmFCbTBuVytwTTVUc1VvTUd0TEk2akUvOGtKMDlZNXVN?=
 =?utf-8?B?UmxEbEs5bzAwSXhBOWlHMXJ1RjdCenJoVWZhaGJGeHFsRWk4UUVXYUgrdm5s?=
 =?utf-8?B?VG1waStkRGlNeUxvWDNCZm5HRjU4NitUTmhGUmduVE00K3VqdTdxQlMyLzJ3?=
 =?utf-8?B?Q2xhYlZzZGhzcmwwTkZUcUhyeXdDK3ladEJqczNFTDhCQ0RGSk1FSzcwejZy?=
 =?utf-8?B?bnFscnVmRzdjZ0l1SFhuVEVVbTVjNzlneUxuQ0c4Q0txeWtRVVlodkJpWXo0?=
 =?utf-8?B?Zzh3dm8yT0s0QVRNNElqMXFWb3lsbDd1Y2NRR0p1TkNlMlRoV2tXeEJTOHBY?=
 =?utf-8?B?SDJnUWs4NytZbmEzeUtOSklDK1AzMXpDeUdTMkJobzIzWkwzSEN5UnpUZ3hV?=
 =?utf-8?B?V1gvMDI4L0lCREgwZVMrQmRrU05DOTZTakI0TGxWc0ZFcnhuL01DenVsYlZB?=
 =?utf-8?B?ZWYyVFBPR2lDaTlHMnFoU0NuSDcrdzNwZGJFdGlvSVgvOWZuOGZVeWNnTWds?=
 =?utf-8?B?NzJMQzloK2p3SmZVbnlxNWVFbjlEampjSzlDckx6SlBTQUkyQjNselhld1cz?=
 =?utf-8?B?cEx4bUJ6a3pMTUlBbTIrSkFYejZWNEVWL1g1Q1ZPWlFIU3NGMkplcUwxa3Bi?=
 =?utf-8?B?bCtuSnN5Y0FZcVRyN2ZQdkJydFlVck5wVlJkMTZkMzFqUU5ia3l3bUl6aGp3?=
 =?utf-8?B?ZzRlRG9GaTFUY2dzOHlsL2REQU90Tm1KZW1DY1AwbDNTVW0rVGJkVnMyS1li?=
 =?utf-8?B?OW9OTFlsVDVFNDNWazdsMHJ6VklIUHFieitxcHJ0eUNPVDhiWlZoT3d4ZTBz?=
 =?utf-8?Q?roSOQT5GkaRJDnOOXn1JGXietBpNKawhV1BMM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M1Zzb2JSMDhDNDI3b1hoZXVDOWZCK2laY3dNSFRVZElpL29FaldQbUtjTExj?=
 =?utf-8?B?dkxVUGszWTc1cFlZbWhLYVAvd2dpN2NnQzFpemUrMmVzSXNDNXlMdFRIWk8w?=
 =?utf-8?B?QU9KVCtzdDliRjRyNXYvTjlhM3F2Z1I3RzVSSUZBSkVIZTNOWkUzdC9TSmEx?=
 =?utf-8?B?QWtjS091S3BXZlA1b1N5ZTh4NXVIRnRSNU5IbGhKeWRuVytaM3BYQWRlVUh1?=
 =?utf-8?B?aTVpQmI0S2NzOVRiYzFVeHFRb1RoVmdzd1hZcG8wUHF4a0NHZU1tN1ZUTmsy?=
 =?utf-8?B?U0pvVlk1SnZkRTlOT3hJNUVPYVdBajl2Y2R5R1Q2eWY0TVN1Y2hQTUgxQjdj?=
 =?utf-8?B?U3ZQUEhNVXorTWxlRHJZLzFCVjhLK0ovcFZGOGNYclNYWlRYZkFlZStPcDZS?=
 =?utf-8?B?T2dKVU9iTk1GQlhiQnZJZVFIU0Z0Z2wzbXI4c3lNQ2hTclBUa3hRRUxMV0tJ?=
 =?utf-8?B?VEM3R1ExTTZMc2ZkRkUzQXFORlVYVHl0NTVPVnVlU1o5VGtTS0xGdEZrTHNR?=
 =?utf-8?B?S0hCbVI5SUZ1ZklNRUwvUnBzRVJUWVFiUjE4ZUxQbDZMNUZDWGdrcjE4UERx?=
 =?utf-8?B?OWdqT3EvN28xSHlzK3BvMEVNOTR3OUt2WXdZdDVZUE1SWE1xUXZsMkNKRWFU?=
 =?utf-8?B?cDBDTVF4MDN2elA5ejFVNlpUWUNwVk5OVE04clRSaXFtR1ErSlpJdXhHL2dl?=
 =?utf-8?B?YytQb3ZwUTJXeGVJMzFCUkd3clB3dmVOQTduc3pScXp3cGFpSUYzZSt5L1pZ?=
 =?utf-8?B?bFAzck1Hd2N1U0swa3Z1K2ZuS0Mxb1Zya3E0UGsrT2ZnUTdkUFV3RFliU0FY?=
 =?utf-8?B?Wk1BMVZYOElyK3U5NWVpUVVocFo1b1d6K0x2OWpwSWJTVmhyQVNvMWRqcGYw?=
 =?utf-8?B?RG4rVmpzMWlxdmZUVzlLdmlvYlJwaTZjb0REUFREWExrVXUwY1VLMVk2Nm9H?=
 =?utf-8?B?T3JlZFg4TnFwSFNOSXRkZExERWhSNVRwaFV5MDAwWGZ6ekxTbmpUb2tXVGZL?=
 =?utf-8?B?dWhvdFVSZ2ZvbWZiVUp6N0NiUkdxK1dWU0xRQ1ZuSE1xb3doQ2dpczdCMTgv?=
 =?utf-8?B?YTFrV2NTclY2amdRUnZkd2xQaVlZNUlMMG5QSUV5Z2FtL01oNEl1SHRFeVRX?=
 =?utf-8?B?M1h0MDVmZy9vcTE2VXg1WncrRFV5djVoRGlrYkZPL3VjSklxM3JzSGx4S3l3?=
 =?utf-8?B?Nm16eHl3ZFMxa2xXSHppY0cyaVQ4VUdaUlJYYmsrdWxwMlQ1Nmc1b0ozU1RO?=
 =?utf-8?B?V3hGb054dnYvS0hjdnJNSVppTFFQNEdVNjNiWWJHNERucGZGODk1dkVWS2Jj?=
 =?utf-8?B?MkNFWGNzWWxBcjhoQTI2UHJoN0F6dUtUaStRSlhEajhja0FBQ3NyMlE5QzNw?=
 =?utf-8?B?QkJ0MGRzUmxWbzJadDJsb1ZNVXl2c0ZNRkFhTFF2YzMyVkNEVzNVVzF2ZDRs?=
 =?utf-8?B?RE8zUHVrSUx3WHRHWHJnNzJsSzhMNlFaaUJ1SVBJRDRNZXY4VUcvU3lJdlZ4?=
 =?utf-8?B?dnNhVkJhdnRMTGpmRGxlTVNqUkZFc2tUdnZ6YVo4Z1VrMXpOZHZXemJoaksy?=
 =?utf-8?B?UDluUUdqU0xaRlIwUHJvOEw1Q01zcUF5T25qcGpjL3FBR2xPL2pQZ0hEZDlw?=
 =?utf-8?B?ZGViOTQ5VmRMYjE1akFHazRIVXpWNmt5NnhGaElEMWdTT1RPaTJHTGpEQjRO?=
 =?utf-8?B?NnFmaERqd3U1SzlXajRjaHIxWHB5bFpJM0lKd2xiRXQ4akxYY1ZkNkZBQVZX?=
 =?utf-8?B?VkhLZExNTUJGL1c5OXcxN1hVK3p6aVBFenc3eGZNMXBTUkp5eTUwTVNCNUZI?=
 =?utf-8?B?eTNuVnY5RDFrSStrSy9ibCt1K2FHcnZpMElDM0d5MmpSdTRETmlLN25rS1lt?=
 =?utf-8?B?WVpoZTR4ZFpCbUc0L09VeHRLN0x0Q0Y3NytpQ0ZweUJITjhaeGpVeVpQMWZi?=
 =?utf-8?B?cHJHbng5d0tQaEt3ZXZ1OGlDT0NjZEZaZEg1WWJTRW1sdXRzME5hbFNPVU9S?=
 =?utf-8?B?NnZJR000U0I3S2IyQU0rZFQ0clZveG1wQllmRVV0a1l6ZnNoUEg1YXhXbklE?=
 =?utf-8?B?RWppSDFoZVBWQWZRbEpVQXJkQUV0SmxSRk9XemlrQm5jTG55bWliR2ZDcVVt?=
 =?utf-8?B?Qkt4TXNwdTJranYxbkFTckVVQlViVUdEOEM5aDZ3QUllSTBFU1drb3I1dVhW?=
 =?utf-8?Q?YIKU45ELzOnVMXnkWTjgePE=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac5b8e34-6005-432c-d963-08ddbd69a94a
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2025 15:19:26.7321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /PZHOZO8fNMU+OaMhoo9W7E04+i0PVFVjA8JZ5Sh+Bn2mIGsqgjR5EfixGZJyI7hUF1CeGo5Ln5OJPbVqkY23mAVtABU4LzZ5fHPFesOxck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB9200

On 2025-07-07 10:48, Gabriele Monaco wrote:
[...]
>   
> -void task_tick_mm_cid(struct rq *rq, struct task_struct *curr)
> +void task_queue_mm_cid(struct task_struct *curr)
>   {
> -	struct callback_head *work = &curr->cid_work;
> -	unsigned long now = jiffies;
> +	int requeued;
>   
> -	if (!curr->mm || (curr->flags & (PF_EXITING | PF_KTHREAD)) ||
> -	    work->next != work)
> -		return;
> -	if (time_before(now, READ_ONCE(curr->mm->mm_cid_next_scan)))
> -		return;
> -
> -	/* No page allocation under rq lock */
> -	task_work_add(curr, work, TWA_RESUME);
> +	/*
> +	 * @curr must be a user thread and the timer must not be pending.
> +	 * Access to this timer is not serialised across threads sharing the
> +	 * same mm: ensure racing threads don't postpone enqueued timers and
> +	 * don't mmgrab() if they didn't enqueue the timer themselves.
> +	 * mmgrab() is necessary to ensure the mm exists until the timer runs.
> +	 */
> +	requeued = timer_reduce(&curr->mm->cid_timer,
> +				jiffies + msecs_to_jiffies(MM_CID_SCAN_DELAY));
> +	if (!requeued && timer_pending(&curr->mm->cid_timer))
> +		mmgrab(curr->mm);
>   }
>   
In v13 we had:

-	task_work_add(curr, work, TWA_RESUME);
+/* Call only when curr is a user thread. */
+void task_queue_mm_cid(struct task_struct *curr)
+{
+	/* Ensure the mm exists when we run. */
+	mmgrab(curr->mm);
+	queue_work(system_unbound_wq, &curr->mm->cid_work);
  }

The new pattern is to do mmgrab *after* timer_reduce has enqueued
the timer. This seems to be racy with timer execution. What prevents
the timer to run before mmgrab() is done ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

