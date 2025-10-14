Return-Path: <linux-kernel+bounces-853308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BA1BDB317
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 22:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D4CF3A8817
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 20:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C9622D9EE0;
	Tue, 14 Oct 2025 20:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="g6f9Xs0V"
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023074.outbound.protection.outlook.com [40.93.196.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5CC298991
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 20:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760472951; cv=fail; b=CfiXjHCgSne2Mooy2WOce20YwOMYFktjitvA5fZF4hxNfo7bZEzn6Ls+ZVQs9KpreuNiEWasfKm4qHdwRGOeYKsBk7RA37UGkKXrvXkJBe8s9VQVsgTzgsjoFCV3mBJsjtWxNPm+/vDh6TKRxnbzyF2H5RXx9rdmCoffblSgLGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760472951; c=relaxed/simple;
	bh=xBrZNjqqDUJjhhGJRvkfnbq7fMN3atNp69C0+gok2qg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AgFs09khlk1NlmpFHzT+ESRRLmx61hx4e5/6vGZRYUG1kUh2ultZStOf3PDNNZKNZdxBZxHtTH6NAAxTgLn2YJ8wuH9Cer1yBrpDo4H+UZitlVX5oWLUp36bhHR8YewPIoGF3hPKwVe4uphjX575OK5GI0WaaqiyBkCdffcv3QA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=g6f9Xs0V; arc=fail smtp.client-ip=40.93.196.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Te9w6VeEJB9Uw8Rn1Qps4bQl27QQQfDKtJKn3gLvgQWI9k8CNjLX7s8Jm9Jq8ysuQQ3hd+jvZviwZ7ZdwQOOSVNgtncRmZAP4Omncr5kZzCgrGn95MEZxXmFJln24aml0G4H/mg8JX6At78GuFhGQOjPr55D34yanib2I7BiiFJul8zLYqME9qL+Qj3tUOXf7c6N4ZzqSAyskukJYJoiRPp1ZjhgnN4PFhMef65cZriBwVwp3FUnCQ0j8HrgeossSgwZVf/CHr7h+rjQlJDrJJdnrc3nQ02aWakHjcsMs2laLAWdz/BTzOwuDfp3E0gdfL6P6APt0f9jBp3aZhB65g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoQYld0zTsJUnsnbrj0kaOGeqcg7V4ogRljFDoZ3LZE=;
 b=rcjXGCeSaElGcyMZYtn5BKVbjXZnwoX2cqt2dBcK/vxHoYm3C9bWMU6IQR/tThi5fstADqdj75aMoU9c4uoUXE8jUDKIxbbfQuAKFsddKylt9Mq5vqWBNSKjcfiWJz27FfMumgE6b4RcDKNhsuox8bEWwTHmETGzznMh7iwIbAqszP9jagv7HyE78NWo7pX/freVclZMppNH305iGqt4WC6DgtuyOkdDe61P0Qze2L2eoRyGpzRsbmSU1qLY1vGxXYPdVjcTFNm26feIVQ3qE3moc5jo36TohVm3XF6BzseF5utv75mOF4VQ4z9J4no3/W9y0R7MztZbf0KYvheqvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoQYld0zTsJUnsnbrj0kaOGeqcg7V4ogRljFDoZ3LZE=;
 b=g6f9Xs0VSOSsIgmbkma142/vBcAR72xlWl6o386B+B0RUlTf5KYOolztbFlnkup6FbhSrppVNIU/VV6WxgRUDANH3qyIDiH61vaUhnwewir2M/rq2WGqZ6j4SWScX4OuT2qI8KHjKE/EFqp+8X1Q5yMDLz6xtTe5kL6hmsgM4hg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SA0PR01MB6107.prod.exchangelabs.com (2603:10b6:806:d8::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.10; Tue, 14 Oct 2025 20:15:45 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%3]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 20:15:44 +0000
Message-ID: <c15c115a-b199-4933-a634-1f0679565e25@os.amperecomputing.com>
Date: Tue, 14 Oct 2025 13:15:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: mm: make linear mapping permission update more
 robust for patial range
To: Ryan Roberts <ryan.roberts@arm.com>, dev.jain@arm.com, cl@gentwo.org,
 catalin.marinas@arm.com, will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251013232803.3065100-1-yang@os.amperecomputing.com>
 <20251013232803.3065100-2-yang@os.amperecomputing.com>
 <973e36b9-e89a-43b2-bb85-b00343dd4e36@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <973e36b9-e89a-43b2-bb85-b00343dd4e36@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CYXPR03CA0073.namprd03.prod.outlook.com
 (2603:10b6:930:d3::23) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SA0PR01MB6107:EE_
X-MS-Office365-Filtering-Correlation-Id: 62e976bd-8e48-42e2-c30b-08de0b5e749b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TFoxZ3VNeXVOZW9meXF3WEpReGV0T2owQ2dQNjZId1pORFg2VFViaWYxS0JT?=
 =?utf-8?B?S2dHZWxpMjdXdmRtOUVHQUZ1THBtU3hTQ0RwOXFVLytkZGF3T1JUSitqVGd4?=
 =?utf-8?B?N090dTBZT3NqSzNvYlNoSjRaNk1GRkVDOHlzZ2FZbzJ1ZjJXYWprNXdKeVpN?=
 =?utf-8?B?RDRBVnVlT20xNHU2K2w3Q1M5cDhPbnVoK2xrUlFLVkpTOU1naXZNV1loeTlW?=
 =?utf-8?B?Y3JHUlowSjRuZXpocEJBeVIvZGo4ZjZtREVTcWVxNzA4UG43Q0E4MWhjaUtr?=
 =?utf-8?B?VWJsSkh5ZFV6eHp4RlV4S0xZU3ZGc2VKQ1djdG5pbmRqQ2M0bEtxa1IxOVh0?=
 =?utf-8?B?a0ZJQjlUaTA4Mnp2OHpTR2tEbnUyVDdSV3VIdnErUEdSbS9YVVFwNDRGZnRW?=
 =?utf-8?B?UzhHMTB1YmJIVW5NYXF4U1BmN0dWVktFNXhnQXVseko1ZnlTY3YrZUM5YW9l?=
 =?utf-8?B?U0E3eFZGWXpxZjhRdUxhbFY0S1p2Vk5VQms1UWZBamROYUZBWWtKOFFGWFJ6?=
 =?utf-8?B?Z25yYnpIYVduZExtcGVobHlER08rbGVJbUpaTUxUUHkrUE01TDltZEx5R0F4?=
 =?utf-8?B?SXY1NTU0T0FYSTFNRVFodjhSb2FSNW95UGtoekdjOHJsQUFjT1YxNlNMRDBp?=
 =?utf-8?B?RXNKQnhtMFRTOE9lZFZFbDNoN3hiZVVOdy9QMFo2R1o4YUNUQlVlUHcwZzVu?=
 =?utf-8?B?b21QSTB0Mi9OdlEyUXNsbHk1MjdXcDF4SHhETnhZYmR5NG94MlF2RDYyb3dv?=
 =?utf-8?B?dll5YnBRcHBmNmIvY2lyNUIrSnBMdXlxQ2VrT0YvWTdvZVAveHlaMTVKck5J?=
 =?utf-8?B?THhHeDk3MmtacjRXTnUxUndXOE5RcG1jeDNyY3V0enZoY01MdHdpWTk4RW90?=
 =?utf-8?B?a3JFeGZBVjFVMGhJNHNBZmJsWmRZUDNla0hweEloV25VNUdIeGx3UElZaTdJ?=
 =?utf-8?B?YWszRThQZ1dzWDdZL3BrK1FWS1dmRjA3Sk1GNWh6d3hFc2FLa1NkL2lSbE1h?=
 =?utf-8?B?TUlpRmJQY2NOTHFheHBiM21rT2hLNmNvdWlpZDdaVm1PTHRSYnFWQ1NJc2d0?=
 =?utf-8?B?MjB5R3gwbi9LR3JUZUpHK2ZGRytPbmdHZ1UzZnR1VTJ3V3ZSQXNiSTZtNnVr?=
 =?utf-8?B?QSt5VXhEbUg2NTNyUDNjWjdwZFJ6ZDZpQ1lxRkdxNzZtT1lUWlhKOFBrQkRY?=
 =?utf-8?B?akw2TjI4cHFqbE0vR0dRY01oTytvY3RyOWVIZFdPMC9QR3Z5S0gwNnJHeStI?=
 =?utf-8?B?NDdyNEU1L2VtcEFkSUNDV0t3NUR5WkF5MkkrT2dNZ1dzYU9WaXBlRWxyTGpC?=
 =?utf-8?B?YVVzQ0s1eXNBeEZXR3RxSCtaa3BsaThld3pjNitCblhUQUtOMEp4MzZwbWVn?=
 =?utf-8?B?Z0xBZkgvTVJoUWQ2WjZLQWpaMUt0dkJIS1BXR003cStDUFNXTWFlUWdrNUpK?=
 =?utf-8?B?RmpnV1NlZFpHdjhvY2VTWlozVkxwbWdqTzlxREZLdEhWQUtyanJVWHhZTkpL?=
 =?utf-8?B?VytrWi9JeTRzY2tITzdCc0V2MFNOZzZOU2twRE0yN2ZDSkpYSVhqWVdreTVF?=
 =?utf-8?B?UTJaaFBTSVBRclo5dDFKUm41ZHJIVGRMd09PR1hhZEE5a2w2MU9HQlRaNUU0?=
 =?utf-8?B?NGxPdWp5SnpERXllK0E4SW5Fd1hSZEZlakpSaVhoNmZ3Y2orOHFnS2NIVUV3?=
 =?utf-8?B?eTNleFpsaUthVXJWdHZTQ3cxeFIrWDBlQU9MN0hObm9JOGZLUjlySjR3amFr?=
 =?utf-8?B?amNZTTJBbTNWdjBrNm0rMis2U3NBdVNudHNGZWdXc0RYSjhmWDFXMWVLVmpO?=
 =?utf-8?B?a2NlY0c1K1l3SUJHNEtFU1dyTHRENFlmVVM0T0tSWUZ4L05Ia3VJR2NsRGlY?=
 =?utf-8?B?czNhUmVBbDFyQUhCQXp6bGV1cTE1VFZTNjkyWkhQZGpOSUgrMmdMak1SSC9N?=
 =?utf-8?Q?maIN+bASwxBa6q9Fq2NEhn/l3tnsIDUU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWp6TDFEM0FzWmpPYXI3MlhBeTV1WEZleVdUVjZ4aGdaTFBWeG9ZWnZQcWg3?=
 =?utf-8?B?OUhKbkI0Tis5RUZuMldkRkRDL2ZpVllZWFFZQnF6T2xaOTVlZWFablo5M3VR?=
 =?utf-8?B?T05qRGFSOEtFNktqUzZ3a2l1TGlmTTl4M1JVK0xseUtMWk5ZeEw2eWdBVUZx?=
 =?utf-8?B?Y0F1Ulg1VWdQZys5VVMxVXdoYnBhVm4vdXJtMnFwN2ZpK3ZtdXl1NVdFVHJw?=
 =?utf-8?B?ZkFubWEwOUd6Qnk3N2dlY2JrUFY4N05mWUJtWkhoY1UzaG16am9DU3dlL1Jp?=
 =?utf-8?B?TVY2RGpUbDFjS1I3YURCR0hIMXhLaGhqNWNwT2F2ekhkMVZGQmJBbjhyVmFB?=
 =?utf-8?B?TDI2KzlhejhnUTgwSGRUMnpRQmc5NmxYMEx4YUl3UkUwTGRGVVI1NTFUVWh3?=
 =?utf-8?B?WXRQMHF3bEdpWldPRWJCUDg3NkdQTEpQcEpkbmhHaW9tamo3UWRGWVZBb3lB?=
 =?utf-8?B?K2ZpYjhlZy8yc3R2QjFjaG9OVnh5TFRoNzBvMmE3cTRGQWtPcFBFZllKWkVi?=
 =?utf-8?B?aFRTdkJZcFpBbEE5UTdTV1p3aVNSZ1BXSUQrVzAvWmhjTnVyMGV2Y28vbGlm?=
 =?utf-8?B?UGl4bGd5ZWVmUnUwVWZOZk9GQnIrSGExdEhNdGhtNWxLQkVqRnlwYS9MbGtF?=
 =?utf-8?B?L2c2a2pJWFZXMWlGSy9RNmZWWnMvQnJxQ1V1S2hwdTZmQzMyd2wrZTFQRGJm?=
 =?utf-8?B?MzI2OHVPdmpzcFdmSS9MaHZlVCtkdnRRY0hvUnVwRlRrWW5QRThRbXFsS1Vv?=
 =?utf-8?B?UkNCemI1Zm44RzdIUkZqQncrTDZJcVQvQlJaeVlZdkFXZmpQMWpzbEI5OTRw?=
 =?utf-8?B?OHNPa0hRaXgwQzVaQ1R1S0N6dDlPenZQcis2WVFnME5MQmtQNHkyMVZvSFBV?=
 =?utf-8?B?cklSUmphVVRjZUtzd3MydHZqTDVKTjFzSmNJYXkxblBwVEppS1kybzJMVitU?=
 =?utf-8?B?NmtnSksrNnVaNlhkblJsMmRFU2k4T2plTXp1VktiL201aS9XVGhQWnk1L3RM?=
 =?utf-8?B?aUxQeXBoZHRacW5DVUZnYmJDdzVNc2JxOUp2WkYvM2pLVlZJdUI3eHhCM21O?=
 =?utf-8?B?K2x5blBtTjZyRmRUR085N1d2bGpGbjIrSUhEbXp4OWNQQjYzenNBcXNwM1JX?=
 =?utf-8?B?WHhWTUVTbC83a21pWEx6LzVrU3ZuVXdQSE1CNmZpWHdXdVZFdzdoSFJMNmtW?=
 =?utf-8?B?VXlSK0ZsZnBWcWpMaW5NVUl0cW4wazhWRjFLK3I4cFlIM0NGVXJyT2hFajQ4?=
 =?utf-8?B?NTRUbDQ1ZWRjajlJdnFFVmJIdnlUNlRrZW1FZ0xpaTlvYXozeU5JeEo2ZUhu?=
 =?utf-8?B?em16SDNpSDVWTDNoNTRrbzd6VDRWbjc1NDhNcmVmQUVFYTBWK3lla3FQSnFF?=
 =?utf-8?B?ajBEZVUvaFk2eVFtdytwSzVveWlJMjUwa0JTbGRxZmVMTy9DMlY3WUxibWg5?=
 =?utf-8?B?VVlueitWeUtCTlFHaVJURXg0cCtzSk9rSjBhWVlTbGZMK05qd2RocUxPUHp2?=
 =?utf-8?B?cGpsMnNQL3RLZkkyTythL3lUdGFaR3pOTUVTa3kxOW5LMnRJQi9yT2FRK0Qz?=
 =?utf-8?B?Tmt6NnVaekt2Y3AwTnlINlE5R21mRXpzSlZGMUNqNVE3UG5qcnRGVVhmVElX?=
 =?utf-8?B?VElZTGdVSWdFRDExQ3E2bVFrOHV2VGxmSktnNTRTS3hKbXZmNldmNGJxQ2FH?=
 =?utf-8?B?Ti9jTk1scCtuVEtmaDIwQnVIdlZFWWhweEVTeDFqUU5NbDhDMjdUSnVnVUZZ?=
 =?utf-8?B?cE0za09rNStjY0Q1MklFajdFSnM1NkN4cFpCbkdudUJvNEROSy9CWW1Xangr?=
 =?utf-8?B?bGZ4ZW1YaHVFNGo4RVhnckRGeDNsbjFMR1RoZERCa1NYYjN0RW5UNWlXQk9V?=
 =?utf-8?B?YXJNbHVrYTdmM3AzcVk5RFNSdFJmU3FLdTlheXBzVXB0U0hha3Q3TERCaFNC?=
 =?utf-8?B?SGo4NE15V2RlOWU1VTNUN21YOSs4UEtiaFRGSkIwajJJSmVnYXUzWHlva1Vy?=
 =?utf-8?B?NmI0M2hDbXdEaWhwc1p1bnkwcW8zSHY0cFNDMlZ5WDc5NWRKWlZ5ZUN5Uksz?=
 =?utf-8?B?TGhadVFDbjEvSDI3NFh4RlJCRnk1eElDWW5MTkw4Tzdob1pCY3BGMWxtVkNw?=
 =?utf-8?B?QVdhN0pMV0M2R3A4SG1DNzh3K05mUythZmhkek12NUNIRGp2aStuZWxKTXRk?=
 =?utf-8?Q?BjhvoEDL6/o1VLo2K12Axw0=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e976bd-8e48-42e2-c30b-08de0b5e749b
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 20:15:44.7554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 84LPmuQ0UGGXA4aalYHBYYjjI3gksCmeXacoae27e2ylSvYaI05irWm5zdzrifYVLtrxQzHaZ7/ncfO6U7Zyf3JFN/RGnuT1XwMWCs4Qu8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6107



On 10/14/25 1:05 AM, Ryan Roberts wrote:
> On 14/10/2025 00:27, Yang Shi wrote:
>> The commit fcf8dda8cc48 ("arm64: pageattr: Explicitly bail out when changing
>> permissions for vmalloc_huge mappings") made permission update for
>> partial range more robust. But the linear mapping permission update
>> still assumes update the whole range by iterating from the first page
>> all the way to the last page of the area.
>>
>> Make it more robust by updating the linear mapping permission from the
>> page mapped by start address, and update the number of numpages.
>>
>> Fixes: fcf8dda8cc48 ("arm64: pageattr: Explicitly bail out when changing permissions for vmalloc_huge mappings")
> I don't think this is the correct commit. I think this theoretical issue was
> present before that. But it is only theoretical AFAIK? In which case, I'd be
> inclined to just drop the tag.

OK, I will drop the tag.

>
> Otherwise, LGTM:
>
> Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>

Thank you.

Yang

>
>> Signed-off-by: Yang Shi <yang@os.amperecomputing.com>
>> ---
>>   arch/arm64/mm/pageattr.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
>> index 5135f2d66958..c21a2c319028 100644
>> --- a/arch/arm64/mm/pageattr.c
>> +++ b/arch/arm64/mm/pageattr.c
>> @@ -148,7 +148,6 @@ static int change_memory_common(unsigned long addr, int numpages,
>>   	unsigned long size = PAGE_SIZE * numpages;
>>   	unsigned long end = start + size;
>>   	struct vm_struct *area;
>> -	int i;
>>   
>>   	if (!PAGE_ALIGNED(addr)) {
>>   		start &= PAGE_MASK;
>> @@ -184,8 +183,9 @@ static int change_memory_common(unsigned long addr, int numpages,
>>   	 */
>>   	if (rodata_full && (pgprot_val(set_mask) == PTE_RDONLY ||
>>   			    pgprot_val(clear_mask) == PTE_RDONLY)) {
>> -		for (i = 0; i < area->nr_pages; i++) {
>> -			__change_memory_common((u64)page_address(area->pages[i]),
>> +		unsigned long idx = (start - (unsigned long)area->addr) >> PAGE_SHIFT;
>> +		for (int i = 0; i < numpages; i++) {
>> +			__change_memory_common((u64)page_address(area->pages[idx++]),
>>   					       PAGE_SIZE, set_mask, clear_mask);
>>   		}
>>   	}


