Return-Path: <linux-kernel+bounces-797515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CB5B41175
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 02:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D163E7AE03A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 00:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD7513D8A4;
	Wed,  3 Sep 2025 00:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="lpv0qTGa"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2115.outbound.protection.outlook.com [40.107.101.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D19EA937
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 00:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756860642; cv=fail; b=O+RNuusDleqfvJCeGdK0zUGQAuGQkAFAvvzSvj211Jfocfqka6OPSHWXoupKHqFcTUkQMi+b7R5volt4/Bb3A7523it2JgI2UyjfK1TOEPoFkkocVIGz1xYfyBlT9/Fz8SPujzlMlubCJdE4jJ+lzAkB2659nfIPyAohLrGjfGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756860642; c=relaxed/simple;
	bh=D/U/eoVUcrSpdGL2TQEK1u1rQrDEUKITvd/qHAqOCyU=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TUdgYpE8BT68wVV6d+GVe+0RkR82pRiimfB8FuOXvv3NiK5SlSa6q0Z/j/S36cOHlggPjncGbLxv1kAwYCf4jVCQxLIjhzqtiCDy2+43pJf6S8KCG6OqDGUUoAKDMszEPG54KViI1c5F4Tis8KMfMJedg1wiwUj0LWmLTVjoFYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=lpv0qTGa; arc=fail smtp.client-ip=40.107.101.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OOKk5BtUWphMRglEdWQdmZAVHLjB6Buq0nJn2LDB2XNuEFrD4ezwqxGuQb4sjxYdkP/4iGVOVi8Fbd00GafQ1+tzkogUJkURk1QLYpLlW0ZhrJSDL5AzPq64udezECXlISNajzBp8sbok5iHf0uBktDJxiXEiFVx32ztr7BzKUZCn2yhorC/lMj6AR52AER87Oi2RSLB3YD7VydD9xLTXm9yrfO0UR7Y8vEf2FL8E4N+FOWT2Pllanl6F/5hem6k3Ys/fK4k7113LLnd9tOZGH3FD1dDfbaMeddYsNUYvJiP0QhsYrQuvXYubrMhpO7p9jSfq1SRpxm3R0DzejYBUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95XfnWx7t/4d8J+7Mrt629jxiJTguJAdFa2GliEpD2g=;
 b=tZyvqpCHIIbn4Gjip4+nvTORWFA03XTV/hPFj2mvHPp9yDDBKgk/KxN1wiuAbPGJRG2O/FIMGck9Jx76aQuDMNGIAPMW0fPUXSNJBf6kHNQSUtcLluQCSAHRF4pb2WVJm2i8K9AL/hX1Z73y6YLvqK2hxqDFc1l//KDweQCSTGIN/ukA+9kW9KAFVg8E8Kp8QLt5aLundAxD36eYAMnBK3SbnlpU829N8Qnc3hvvrRIfDelbZdBvOkQKtVPWoVWpcUija80HELqVqUkfzXoSKMVMqNh8HMQKD0rNG7UzTW2HNKMqhDLrSdEWDFKRExgO+ucc0AJ61gVq4QypyHYD3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=95XfnWx7t/4d8J+7Mrt629jxiJTguJAdFa2GliEpD2g=;
 b=lpv0qTGaMAIA+KjiA92S03xUF/eVYzvI6eunL/EuIjCkS+NIELDrh9GVFtYdR5c0cCf2A5bQRGsL9lvF4p4iXvKg6p2H6OoJsxOOKi99T0wGk4cP+swuGsvlCJk9YC85OmIFhb7amEKrB9itmpr8pqiNzwkNlMNHgTxts6aVJe4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 MW4PR01MB6322.prod.exchangelabs.com (2603:10b6:303:7e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Wed, 3 Sep 2025 00:50:37 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 00:50:37 +0000
Message-ID: <612940d2-4c8e-459c-8d7d-4ccec08fce0a@os.amperecomputing.com>
Date: Tue, 2 Sep 2025 17:50:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/6] arm64: support FEAT_BBM level 2 and large block
 mapping when rodata=full
From: Yang Shi <yang@os.amperecomputing.com>
To: Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Ard Biesheuvel <ardb@kernel.org>, scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20250829115250.2395585-1-ryan.roberts@arm.com>
 <e722e49a-d982-4b58-98f7-6fef3d0a4468@arm.com>
 <dd242f5b-8bbe-48e8-8d5f-be6a835a8841@arm.com>
 <aeb76956-f980-417f-b4e7-fe0503bb5a2b@os.amperecomputing.com>
Content-Language: en-US
In-Reply-To: <aeb76956-f980-417f-b4e7-fe0503bb5a2b@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CYZPR17CA0021.namprd17.prod.outlook.com
 (2603:10b6:930:8c::26) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|MW4PR01MB6322:EE_
X-MS-Office365-Filtering-Correlation-Id: c0c65bf0-aa70-457f-03b0-08ddea83e5d5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZEZUWHpoRnRLWVhWaUhpdlE5VmUrcnU5c3RIRFNjSXk0U0dvb2I5TWxBTG9D?=
 =?utf-8?B?MVFieW5SSHpUNVUzZFZsUEpVTEhmR1RXcWI2TG5lUGpMMlR4d1VaSHZORi91?=
 =?utf-8?B?WCt2NjFVZVlpTEd4ZVpqNVczUGRTTktKWkJ0ckE2OEw1NGJWTGE4NU0vcFdw?=
 =?utf-8?B?aU4wYURaclROWG45TmQ2Tlozd2ZHUFZmSWMrS3MyeTg5V0xDRzRMRXE5ZXB2?=
 =?utf-8?B?NXcyVlZPNW45c0tHY3Y1cXZtVXdpb2QzWS81bFg1dC9jOFRwWEFIUUVYREFl?=
 =?utf-8?B?ZjB5VktQWnBkbEZyOEpCaXliNkdZZGFIKzZyTmIzMkt2dnUyQjFlcFl0OHk1?=
 =?utf-8?B?RCtvY2xxNWQrd3JUb0UvRWJjdzVmcXB5ckl4UjF0NmM2eXFoMFFzd0JrR0N5?=
 =?utf-8?B?TXlXa0czR2xpMERMSld4TSt0cFlKNmRoZFFTd0lPczI2MGFjalhzYkJCOFBG?=
 =?utf-8?B?T2xOWEtidmlIQVAxa1hJaVZuN0p0SG9PVXJnckNhekRvSjZOVHAxdE50Wm1E?=
 =?utf-8?B?eDVmRkNac3NNNjA4Wm10dU96clcxTHZNUk5qZHFvbVBZTUMvczR1Nk5RZmZy?=
 =?utf-8?B?aGVneHF6d1VzOUEzdi9ISndESVFNT2l1OE4zZlRZdTMxL09JZ3hDL3dvNHE1?=
 =?utf-8?B?S3pLUXpTYjNJMHBUbU1DMUZHODNQZmJ4ZXFXRXZSb0lUTzhhWFp3bzQ0K2dr?=
 =?utf-8?B?V0I4aWhOOG0vWnVnMlExSStUcjdEY3pURE1wbmxINzREWFlteE4xMXFMZFpS?=
 =?utf-8?B?WjFSYTlMMWpkSFI2ZHhCZm9wRDRuZ0Q4UXl3eTU1THBOSWtYaFJUYWlvdUpa?=
 =?utf-8?B?TlFLUkdBNXF5RFRZdTFVVDVkUXZndGZSNnM3R3RXSkFJWEg0OUdrR1RoN0Ey?=
 =?utf-8?B?b3VFbmJvZitJZnJzMGFyNU9Bdk0vakF2eDBIZ2xQaE1UQlF6d2tYZG5nNmd5?=
 =?utf-8?B?cDgra0R0emtVVVdpdnBmb3FLS1lmb2Zqcmp1RUZRd3Qyd3lHcFMwZXpzcytB?=
 =?utf-8?B?MWkzYXFPa3lGcXZiRUJpQmpUOG0xOHBVSU9sdmFEanZ2YW9MWW5CWUlyeVdm?=
 =?utf-8?B?cUdKWDdrTUJsZUx2YWJoVU5DQVg0T3BDV3AzK0IxYTZQM0drOWtUSkFDZnM1?=
 =?utf-8?B?VkpIeGZWSHhVN3cxYktMWXRZaDFjc0ZRSmpFZlJpcGl4ZDRYWlUyK1Bhdktn?=
 =?utf-8?B?Z1FlVDVkWXBFaUlsOUdDRlRYR3NoODh6bnRPaVYwNmZ2NFVyT2hOMEwwMjBV?=
 =?utf-8?B?a2xvZlo1aFdubVNYUFhsZEVIWnQyQ1Z3M2pnL2pNQzROK2htRWhFcW9qbnRa?=
 =?utf-8?B?SGx3UVVrVjVCZm1VcXgyQkl6NVlra3hoV1hHMXRBNVdoL0o5SzRmQ2FQVzdt?=
 =?utf-8?B?TUtycVp4aEVFMjF0Q3ZuTWNCUG41VWJQdEJyczkxT0pqc3EzRCs3aDNhdWRs?=
 =?utf-8?B?MDR3RjNGcUZDQ2w3QTIyM0JvZjBNanMrODZqYUJZWXpRWlVvOGpmdzJBR2Uy?=
 =?utf-8?B?KzlzMnlZMnhLU0RSK0VxVVJTU3ludnpGeTlQdy9Ha0xVcXpTdHQwK0tsRDF1?=
 =?utf-8?B?ZjlPZXBVTmtzeHBUUDdtNTFJQjJkVVAvSHNLUVViTW9TNUVGWmhEYXFYNjBN?=
 =?utf-8?B?dENCWGhjN0JlTG1ldndhYXYwalVPMnkyUXJkZFJHdEZvUExuTWtlSGpKZFdw?=
 =?utf-8?B?T2p0eWZybVNxRWNaQmhrN0tqcU1vVGpZMXRrSCt4Y05mU3dIVTZTdDFXUnQr?=
 =?utf-8?B?Zmx1RWp0N0V1Nlc5b3h2cTNRQkpJZU1STFRYM29rdGxOZ1F3cEsrWEZDQVpj?=
 =?utf-8?B?WUE2aTVZbHlSeHhhUklMd0Vsa29xUGt6dkdNNDR2YitYUndVUkowbXVzOU1S?=
 =?utf-8?B?cUgxSXcxOGRNTGlHTGV5TjRWTzFpWUo2cWthM0hnNXVCV0pZWW1FdEpjZHdR?=
 =?utf-8?B?UWk3YU9WQ2RJanVtVXlFK3pPUTZhYzJzN3ZqaDlZcTNZeUNpT3JWc2toVVNJ?=
 =?utf-8?B?UXptNDhRLzdBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzNWc1lyYXFGTEs5QVVXLzYybzBERUZKVFZ3aXhPTW0rSi9pUlkrMXlGcS9E?=
 =?utf-8?B?QzNtdm9jaUVnN0hrbDc4ZzI1ekpFVlFXMHZOWXVoOHZic3pQNktmalpXT2VE?=
 =?utf-8?B?bnNwTVBZL2hldXZvTkJqMk1VRXRWYjE0SmFyUDhrVUtxK3E4QWRzNDM4eVVo?=
 =?utf-8?B?R1RwcmpPVUhCT2xlMWxVNGRjZnMzUjBDZDhkZDZQY05BeFhzLzJUZWZRbEpW?=
 =?utf-8?B?Qkl4N1kwajcvVXo2R01yWmtWcWlEenJVVUVFZkk1UHU3eUFsdGNhMUEyTzFC?=
 =?utf-8?B?aGtCb2I5eVFZdUpVNUhucFhVdXlkRGFvOUY1emtLeEthLzE4R3ExRGs5blZ0?=
 =?utf-8?B?T3Q3SUVvdHdCRW9ZT0lYV3crS2s0ejZCWTdtc0NsRnpMZS9IaTZPNjU1M2lj?=
 =?utf-8?B?U2NOWWIvVUFtNExNblk0dXI2ODJPNUtmeWVVbytPcXJFR00rdWZUSmEwUlZ5?=
 =?utf-8?B?WEp0Zjl0VnpZVUtIVEdVRlkrcndKaWhWTkgvQkRKN0xhU0FaVDBQRGtHMnhi?=
 =?utf-8?B?STRQVStLd2J0Y3FLMXBMcGsyOVgzcjBISE9KdmJjUStSM3hubVZydlBJU1p4?=
 =?utf-8?B?ZDVXdmxQYXBaOWRtTTllN1BUU3hJcVRJZUg3cUNhMTFEOGd1VXdlZ2srUFdI?=
 =?utf-8?B?bXV1WDZ2NTlWNXRBc2pKYkYvT1JscHFtTVVBRWJ2TElyMldKckd2WVZKVDNI?=
 =?utf-8?B?dEwyaU9HRTBzWERxWnFiUWVWZkxkNXVoeUJldmpFNFFLMk9jcW1GWEViS25a?=
 =?utf-8?B?bnZ2Q1NWdkhTUjFXTk1DNUVCR0MrUE9KdTZvRVVZOVhwWTlNOHlLOWYwQTZn?=
 =?utf-8?B?S3ZESERLNGQxM0dHcW5qSjdHL3lZejdrZldiNkUyMThHVlpVZ2pWWENXMnNh?=
 =?utf-8?B?dms3ZVRtMmdUS1QrQ3RmYzRQNThzbEhSY3gwYzJxdFFiMjVDUkZ0UXlXa2tF?=
 =?utf-8?B?ZkF5bVQ0WDBSQ0c0WWZQRkpWV2Q3dm5pQy9EYjNheTJldzYxbElsdnhMMm5I?=
 =?utf-8?B?TjBxSlZyYWJtSi9HTlBwc0JPWFZHRGhXbTJ2WWV2bEZnYkJ2VWVTZ0kyTjVE?=
 =?utf-8?B?SC9YR05WNlRYZ3JOSUxpbmx4eitwbVQ5cVlHR3JPQkpBVkhIMzJhWEt5T3M1?=
 =?utf-8?B?VXd3bzBhcStOYVF1c1ZweWxsdE5pZWFQeWErci8rbGRMemdLbCsvT21CYjY3?=
 =?utf-8?B?ZDkwTmE5ZkxOeTBBOWhqMnNQWXRCQkM3djd0ckxweDFUbkQ0dkZrWHJTSHJL?=
 =?utf-8?B?LzEwVDdLbDNncmphcmpwNjY0UXJpbzRkUng5RzVZd3pwU3JDbG0xWkVJZWpP?=
 =?utf-8?B?clZ3c1BWMFU4MHhUTWRTNmw2ZVZHcHU0VTZ2QnQzcGNybXp3WUh2VTYrMXIv?=
 =?utf-8?B?YU5hV3VKK0NWM29wditzc2ppNk5KVGlqZWY4VkRLanpSMVQ1aGVMNFlmRzRD?=
 =?utf-8?B?VHBJeG8xNlF6cXZGaStRQS9jdWJMbGh6RXZWUXljc2pVRnFvR2R1bUtocnNG?=
 =?utf-8?B?VUxuamV6OHZKd1FIaUY1MjZUcVNwYzBDNnorQ0NTWXdnTlljMzVIblhkUHFv?=
 =?utf-8?B?MmI1RHZ3ckR5bU1FemI1RloyN21mZlhoY0ZBYWFtdHNJUy9lRGJQblljbkZo?=
 =?utf-8?B?eG03MnAwbmtBMnEzb3ljVHhQT0t3M0pVeURkc21GeEhURmNJWXFwejk2TkJX?=
 =?utf-8?B?YnlqY1lrWTRjdEgvRnVFU3o0SndPUVFnS2lKS24xa3JlVzBVcnN2ZGx1bG8z?=
 =?utf-8?B?UHFiMkpCakZRUVNQcy9wNnMwUE1xcVBYVnNQUC9wblZMMXk0SUNOc3BzY21W?=
 =?utf-8?B?ampZYWlMWGUyYThkRloySGxnS2IrVG8rS2Y4bzNrN1lUSkFjdkc5cDBCbk0w?=
 =?utf-8?B?MlcvY1dzWm9NY084KzFUekYwY05wdkRicklkU3ZwTGhTaVdqNDdKZG1SSDh6?=
 =?utf-8?B?YllETmRXUmloRzJOcXRybkRBK2o2dEFmMTRKWWg2OW9uNlNDbGlZeDBsMWlj?=
 =?utf-8?B?TzVObGRxR1JKQ2lEcXFralc4UUg5VlR2RXR4TE9WUktpYzNIcWp5UzhjRFI4?=
 =?utf-8?B?ZkdFQU9IUDNNb0VWUHdoRkY3L0RyL0xUcWs4cHBrSDE4dW0zeVBsVEVRdUR6?=
 =?utf-8?B?cy9WVU41TzFyd1RnNVJPSXVlUUQ0WTZvVEJ3c3ZwVlR3eUJUQmxHdzBuSnpu?=
 =?utf-8?Q?etrRJZ+tzCiaq1+EKaWOW+M=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c65bf0-aa70-457f-03b0-08ddea83e5d5
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 00:50:37.5859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kgeLJ4zailIMo7J2bfKJkG4p9+8hRqpS9Pluc06Q9r0LFh76WZhbab16GxbaQEN4Fz3HU5nAQ7fItG3vjV0sistXteDtFUEuCuo8CN287Q0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6322

>>>
>>>
>>> I am wondering whether we can just have a warn_on_once or something 
>>> for the case
>>> when we fail to allocate a pagetable page. Or, Ryan had
>>> suggested in an off-the-list conversation that we can maintain a 
>>> cache of PTE
>>> tables for every PMD block mapping, which will give us
>>> the same memory consumption as we do today, but not sure if this is 
>>> worth it.
>>> x86 can already handle splitting but due to the callchains
>>> I have described above, it has the same problem, and the code has 
>>> been working
>>> for years :)
>> I think it's preferable to avoid having to keep a cache of pgtable 
>> memory if we
>> can...
>
> Yes, I agree. We simply don't know how many pages we need to cache, 
> and it still can't guarantee 100% allocation success.

This is wrong... We can know how many pages will be needed for splitting 
linear mapping to PTEs for the worst case once linear mapping is 
finalized. But it may require a few hundred megabytes memory to 
guarantee allocation success. I don't think it is worth for such rare 
corner case.

Thanks,
Yang

>
> Thanks,
> Yang
>
>>
>> Thanks,
>> Ryan
>>
>>
>


