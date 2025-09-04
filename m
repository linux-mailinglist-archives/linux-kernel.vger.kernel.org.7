Return-Path: <linux-kernel+bounces-799642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB808B42E71
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 02:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AA731BC44F9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 00:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169F714D2B7;
	Thu,  4 Sep 2025 00:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="keZxe+9n"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2099.outbound.protection.outlook.com [40.107.243.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C022710E0
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 00:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756947139; cv=fail; b=BoTzWJu0wOl5XaYGDl5vJFBnS2zd3R/Nqe2Ql+G2Znr0J/hDqiDRqen9r1wn9wFUZmJnolSwDqdU2Qgur0FYraxaWDoddwF58T3MqI9rZmPQ2y184fOCf6JIqqtQXzhgnMLYoSMlHDa5BNasNUP3a+o23zSrMe87AAXfCyfnXuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756947139; c=relaxed/simple;
	bh=owu3hzB+zzl3YMzdn7ucFk+twHZ9ut5q9NFLZNCoR8E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QqC7cACrRF41bn5IEPpkGmXgDy/KjUdLt6uoRU004YL2wBLOb++G3hem+HlLxrdfGbe1fRWQNi7wil5MgI2EEWcrGQVNf7MXdXNktGv88zwmBuH/WuN285kNOvbxDKI9UtzolLK+rMNROeoUSAyj+Y7kc8gRA/Ff9AOH0DCcJBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=keZxe+9n; arc=fail smtp.client-ip=40.107.243.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKJlMsTtXnZUY8lUrv4y8X186Xf9/QF+Xg65kAmsyobG1B08V+yHhhnwQ3nBMhKPsw37m/H2WCjnUraiunqNbOLOLK10ilaDNYrAv6Mc9XmzpSi/6OO0fsyfA5VRFw21RMW0/VqRfJuZni0fCiKt/pwTZ484vqSEtce9Fa3/TcttHFmj5FO2D5IXfBOcKjAGkKFj7cvZM0YuYgol8EhwwPRzlmBtaq37Mmfzq3P4H5iTOfyYqbzulDPKvCV+0NC+GuUkhrjqAnJNMp9twi1mpQCYbgIW9eDmFVyAIqkHiv8DeDoQEN//u9oNkIZbOCpA1ByLNJZXZegJdzWm/dOq4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nDdhcdIoG9/zlfeYm4ArRcS7libMYgR/pNNdqJK6E5A=;
 b=TsTBa85WYRWDulPFQAljbvUYSiBbskuXX8HJu5GPhGNT3/6Way/BmdUPmaFuthBOZSo1gtHNLBO1b++jtrwNIyXNDFXyl22znAwXgpoMnGWp8rtVoHom17fagM7fl0VQfQudGYl51AC+cT8YF1foUBErNHo+VwqwhPrQS3GxHRD9PVkWE9HnImi/NpH2htZcdoWMveVbJIG6/G76GrZitkRxjos+LeVc6PZRXIE4LeuKZSqhf08pyDtzbgtt9Y9OtirQibU1WuhoStn0/eq0X0OOgR73Lu343tX+WLRVmeHwgaIDwBvcnpEJ23jAzVQ9leMUWzVy+8K8n1saNsyWCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nDdhcdIoG9/zlfeYm4ArRcS7libMYgR/pNNdqJK6E5A=;
 b=keZxe+9nNOM1395t1UCd3eTlwIispccuqcCOLRU5CmvQ4g1c/UeUDTyPRtLxUpuyyoCuCSjUL8sJB3pSvrUEDlCFtC+BXXEyh6ZotMxn3lv2d9gxaghMEX4nvPBpAbFlkTAiVifm2vx0WRATPTlqf2t8PJM4ubp5c3Rzl2Nw8Mo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 SA1PR01MB6735.prod.exchangelabs.com (2603:10b6:806:18b::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.17; Thu, 4 Sep 2025 00:52:12 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.9094.016; Thu, 4 Sep 2025
 00:52:12 +0000
Message-ID: <dd9e94b3-d6f1-4440-82f3-322ab9b8e6cf@os.amperecomputing.com>
Date: Wed, 3 Sep 2025 17:52:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/6] arm64: mm: support large block mapping when
 rodata=full
To: Catalin Marinas <catalin.marinas@arm.com>,
 Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Ard Biesheuvel <ardb@kernel.org>, Dev Jain <dev.jain@arm.com>,
 scott@os.amperecomputing.com, cl@gentwo.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20250829115250.2395585-1-ryan.roberts@arm.com>
 <20250829115250.2395585-4-ryan.roberts@arm.com> <aLiTzJ6E-YBIYuGo@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <aLiTzJ6E-YBIYuGo@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::17) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|SA1PR01MB6735:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a2a8c42-0ff0-472a-4ab5-08ddeb4d48a9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OU4rb1Z3ai9Ud3FrWnJTY0VxV2pqTTJsUkpFTElJcDIvSHI3WnNGUll6WFhz?=
 =?utf-8?B?emF4OTVSdW1UeXJUUFU5ZEZkL2dWYnlpcW5sd2pUQzRkcG5NdDRhcExKOWww?=
 =?utf-8?B?VDl3WWJZYUpXbm45MitFYzFlT1VhUllXbWFUZ0hBM0MrOTlQYlovWE9sQXlN?=
 =?utf-8?B?NzUvNW9QbEdvTGN3QWhNQkpjTzRnY21tZjhzWWRTK05tci9qbFloNzFMNDVS?=
 =?utf-8?B?U0FqUFZlcHY0cnM3QVZxUlBqMllJL01XQTkyTEs1cUJsbC9ic2FNVUZVbU9r?=
 =?utf-8?B?V0oyaWVBbWtsNUM3eXh1NndNQUZ1QlNXbEFSL25vZnlnSmhWS3JWWXVLci9x?=
 =?utf-8?B?ZkZqMGtqWk5yaTBSN29tSGplQ1Iwcmd4RGhHRHNGcG13dHNidDFjUkJxWVoy?=
 =?utf-8?B?cTRXZ1dnNkpIbTJQTHMxSEFZSG50VnRVZUViSjMzK2VwcXJZNGliTEE5Yjcx?=
 =?utf-8?B?TGh3MExZQWdTdS9MLzBvZ3FkNmpraHlCNWN0RzJqMjlLbnIrWTVwWm9oOHJJ?=
 =?utf-8?B?UjNubWFyL3pNY2NTYmMwdDRxc3l3T0RXUXg2NTZEVXB4QXY3YktveXMwZHU0?=
 =?utf-8?B?ZGR1S3VUOERqNDlZZmE0OFNldEFueGUvc2NQMG1tN3grY2NSWEFmMDZjQ04r?=
 =?utf-8?B?S3dNaWRoTHB1UWg4SXFLeFphUjVmTVQxaTJrOGJpVHlZdndseE00b3hFZTVY?=
 =?utf-8?B?Z1QwRm5lM0t6V1RiQzJkbVUzMFE1MEcxV1lHNkRleURXODNOWmtLNDIvQ2Zm?=
 =?utf-8?B?R05oTC9mN1J5RUNkYkhmdk4vc2p4bHczK0ViTlMvOFNLaUJ2NGdVZEhKa2ZV?=
 =?utf-8?B?NFFQUWY5RVZ2clJQS2xzc04yTko5dTFtekpIaDhmT1RwTVpvbFZHSnhFTkV5?=
 =?utf-8?B?bVB3SGNuNGFBUUJZU0xPakxqSWo4aThEVkhnOXlsQ3dQejhtWm90YjV6Qkdr?=
 =?utf-8?B?SDM4K3pCNDhGODk3ZWRJRVFtL0N0bjE3OGZzUHg3K2ZleVRrOWdvSko2bEtM?=
 =?utf-8?B?cXFNcVByYmVXYVRSR3U3YmtJQlViMCtNYVpkZXRQajVIa1hXTU8vc2wzZTJ4?=
 =?utf-8?B?TmNrd0pVZGpvWUpEZyt0b0c4L1l1d0U0TkMzdXNxMnZhMFBJNndLVCtQMjNW?=
 =?utf-8?B?VjFZdER6TVFLQkhtcy9pc1NZMG9DNGwvUmRTRmQ1dWFqY0xmYjNTZ29OdERU?=
 =?utf-8?B?NURPc3VDZHNFampLRGlxUzZjc0Y5NnNicDJyclRyRTZjVzhJNXJCdHBhSm5I?=
 =?utf-8?B?dTN5NjhyaXhrVVlGa2NZeFIzMlF5NGx6SENOY2I1TWh3VlN6bFIyQzk0Ym53?=
 =?utf-8?B?YThBQXVmc080dzk5WkFIalJxSllCZGdQd0dRZkVYNWZEUGwyYmFtTDQvOHdh?=
 =?utf-8?B?cjdYa09BaWY2dHlzckpIZzJyQWo4OHE3Q0lkaDYvMm1HaDBJSGc4N2tSNG02?=
 =?utf-8?B?VjYyWUlYdkJZdlhQVGRnNDUrOUsyVG1sTGdpVU11ZjQ5c0U3YkhHS0M0RFVm?=
 =?utf-8?B?aUJ4ZXBSS25LaDlWSlU2d3dJbmhZbjNqSitPRXlOVHF5eHU0cjBUQ0txNVAw?=
 =?utf-8?B?T2VoOVNyTXRCWU44WFZHVzJ2cWVPb0JndXhPdXUzWTRKaW9Hc1lxTm44NXkx?=
 =?utf-8?B?NFFDK0xMZFlVZWlJMExYa0wrcmZaU01MSXdIVnpYUHEwUDBIVEExeC9wWEMy?=
 =?utf-8?B?N3AwMTRiVVV1UFZ5OEcza2FZZ05acGcvdER3cHFQZlBVQ3JWNWRhRFBqTEgy?=
 =?utf-8?B?bThENGVIdk0zelllaDZHckVFNFNkNkh2SVUyZklpclNmSDd2ZGhLVklGRTh0?=
 =?utf-8?B?MmY1eXhCUlVBU24yZkx1VzlQeXovRnlyRFQ0QzFIdW9ldDNwN25CNXhmbHF4?=
 =?utf-8?B?THJ4Z2tEZXNneWN3L3daM28wdDlkRUZqcGtEQnFSNkIyOGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3hRSXREdmZpbXpSLytUaEJPOEZobjVraG1ydmxNZkxoVTcveDYzelAvN1ll?=
 =?utf-8?B?bElnRkhBMjQvVk9wMzhDUGxCR05tbGhlWWdGM0s1THJ6Z00va1ZtNTBBSGRp?=
 =?utf-8?B?a1RsbG1TZ29aWjBTMU5ZaEVScjhVUFNpUWVJZ0hLM1pMaWovUm5FcmcrajFS?=
 =?utf-8?B?aHE0NzFRQzhlVStNcThhK3RscjFOcWVmNmpvNmhpYkhyV2Rqa01LbFJYWDVw?=
 =?utf-8?B?UGV2ZThJR0krd3huanliL3hYL1c4TEthbzVUSWowOVVMVUZMWENYYzdIQXBD?=
 =?utf-8?B?NzdUQVBLejJvL0QzVUUyMktGcEQ4L1ZrK2MzTGg2YThsOFlJZXNJbXlDeXBm?=
 =?utf-8?B?Qnk2eFZrN3huLzMyVllBYS9yYTM1d25sbURtYTNyRWpNc0lVa08yNm54Ty9t?=
 =?utf-8?B?SWQwUFNacjBQQ0FuQlJJdEJCTHpNNjRJQVR1NVB3NUZ4Z2J1T3hsakg2UURo?=
 =?utf-8?B?MVBWdnNhUDA5L3ZsaTRqbHcxejhCMlhWRFlUVkMxRDE2UW02b3hzUFBPbjRa?=
 =?utf-8?B?T1R4dzBuOWJEWFFGQ3NvcEJ1RUcxclhqZXBZS0kydWRlNDZoZDRkL0xkeTd1?=
 =?utf-8?B?a1I0c0hpT29VSDhyZGdBMWFzRVlzVndiZHZESHZEY0pOUC9LRWZ6K1dLSWlP?=
 =?utf-8?B?M3RrSG9CRXdGWWFWbFV4K09iT2tmdUVJYkMxbEJZNkNqaWdhM2VMMm5zOHFN?=
 =?utf-8?B?dmEwdG85VlEzV0JaOElpWGZJNWNRRVBtMy9IL21EOHVxbVNLWG1rTHBHYWVM?=
 =?utf-8?B?dS9NaXNwaGVmODkxSW03dThySkEyYXpudmNMNmt1aDA1akFUS0MycDRGakFF?=
 =?utf-8?B?WDZzZ21GY0prNnpReWRUS2tOeSszcVBiT3NvYjk4YW5xd2F0L1ErbVpyZ2xM?=
 =?utf-8?B?SDZlYzljWndUaERkT05OMmc1OGZIekJQaVpzMFAyRUVRNlVuNW9MWGovaDN0?=
 =?utf-8?B?SVBTY00zM2VvUUx3MWhVTlNtODdYVGFNdkhVZ24yTEhwRWFqOG83eFZwb0ov?=
 =?utf-8?B?ZzBUQlVvN0U3U3BzTHVmQjQ0Wk9lRzZ0YXBDYk51dFk4c3dkajVPdEVkMk1v?=
 =?utf-8?B?Y3NOS2kvSWZzbXZSaTBOaSs0cmRiTnJqNnNWL0NlWXg1Z2NGUDZxcVpmUHZG?=
 =?utf-8?B?b2VKVUkxcG51YlJJVjdyc0hmUGdmZTM0d0s0YmF1anFDT01jaElCampMMDE3?=
 =?utf-8?B?MGVTVFF2VmliQmcxV3dVQ0owWnBDbGZqUGwzZWFWUm1oaGh5VWpHRzAwUnhv?=
 =?utf-8?B?OStmTUF2MEdPYlVtaVUwb2g2RjE4U2hSekg4bXRXSkt6SXhKQk1jeXJWQkVQ?=
 =?utf-8?B?WTM1MU0zTGxoYTAwNjAzZURxaHN1OUZLVjR6MXVuUzM2c0M3OE8yNnY2WjJM?=
 =?utf-8?B?NHVPcm9GWm01MDliTjZySHNoZnltY1V1ZjRlazIxaWRyK3d0Tnh4RTFyMUVz?=
 =?utf-8?B?dnQyOGZUbG85aFpNdEJtOC9UQ0ZkVmc4NlpvZ3BEaU80SHEzN1hHb0VHNlBq?=
 =?utf-8?B?K1g4REFvYUdGZW5ZV09iSS9kSHdJZVdWak9tZnVJSFNNVUp0N3pIem94bURG?=
 =?utf-8?B?Qkd4c1ZvWFkyZHJrOFE5dGtKQkJVT0JlcGxxRk02M1RHWVp6d0VCMDhpU1VX?=
 =?utf-8?B?OXpCRjlVRDZhTzNLTVNmcy9IUUxnNGpNZy96SlNrY3pEb0tvRGNWa1pJcXNx?=
 =?utf-8?B?TzNXNktnalFXeExEeTVnY3FaaW1aZ3BXY3AwdEdVdXJQdXFjK1EvcE5sS3kx?=
 =?utf-8?B?UW5UaGgwcjZ0TDZYSUxQMEkrUWdjZiszb2pUK29JeCswWEZoSFRVZno1alBz?=
 =?utf-8?B?OEFTOUkzTUhRL0drcFVJZTc4T25xK056ZnBsa2hxV3BwSHhuaHl0ZHhSODBY?=
 =?utf-8?B?eWVReU9Ralltd05BbVlzTmdRMElwbys4Q3hHMi9RY2NqWGxJNEwzS1RnZEhz?=
 =?utf-8?B?NHp5NzBJOEp2Q29EODZlbFJIRFpLdEN2djZQS09IYjV0cWtpUEJoSm1XbnBl?=
 =?utf-8?B?aGVzKzA5bWJNSUZCK1Y0dnVBd25oL0c1cmtjWWo2OTVENWhtbnU5eVhGcnAx?=
 =?utf-8?B?VzRId09XNERUdFo2YTRQWVF4TjJxa1laeVBOanVYeHVlYUNuZXlmVlpoT0Z5?=
 =?utf-8?B?L0tHNzcxdERWd1hRYVRKTk5XS01yVUJZREw2ZjV4M2wwRGRnQ2cxb2pYWi9l?=
 =?utf-8?Q?GDOy0kwYVy1GBMkfCcaZ0MA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a2a8c42-0ff0-472a-4ab5-08ddeb4d48a9
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2025 00:52:12.3637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VSj5vZmnNm+5hpSBerFdmlyXPhBoTICYFO9UL0dokxy1489ZFf1MGBkMXocKzwVHvpUY6mp5ZXwm99VFI8EV3222h3CG1QYG/18XRkycDCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB6735



On 9/3/25 12:15 PM, Catalin Marinas wrote:
> On Fri, Aug 29, 2025 at 12:52:44PM +0100, Ryan Roberts wrote:
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 34e5d78af076..114b88216b0c 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -481,6 +481,8 @@ void create_kpti_ng_temp_pgd(pgd_t *pgdir, phys_addr_t phys, unsigned long virt,
>>   			     int flags);
>>   #endif
>>   
>> +#define INVALID_PHYS_ADDR	-1
> Nitpick: (-1UL) (or (-1ULL), KVM_PHYS_INVALID is defined as the latter).
>
> Otherwise the patch looks fine.
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thank you!

Yang



