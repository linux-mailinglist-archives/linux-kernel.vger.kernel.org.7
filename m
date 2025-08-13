Return-Path: <linux-kernel+bounces-766572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC647B24877
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 943ED882645
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4345B2F3C05;
	Wed, 13 Aug 2025 11:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HdXiWSRZ";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="HdXiWSRZ"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013038.outbound.protection.outlook.com [40.107.159.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED98212541
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 11:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.38
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755084661; cv=fail; b=pHLpBClIiHoG8r43wjCiBWM44jTnrv6kpz1wDF2siJV7aKeL/Yn+ruLbv2zDGWfllWsKmGpo2noy+uSGJp2DWJ6voC1tjnEHdqPWi2uiGiKdeVm71UoZBCjQ3qVxNPfw5MVUDQazvYP64th4TFyIBlKmHbvqmGj7t60mqiTv6m8=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755084661; c=relaxed/simple;
	bh=WE64hQNzFbRT5d7b72NjD08P851Jh21A1Qk1hYYoBnk=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aa/cXSx0meuDoyXZLiy+VDbkoLQSN8HT7PSR6QH7ydjL5PANjlhDCIN1gvrBYCf5MeMXedr/YVBKnqiXPbUGlAzcRVn6YEZnfsb7W/VjZSulEvftgfcqqpC/sqFa4rwp89o1q3iEfKqU8VNWERra/7SnQc7FxFnlCkGfTR0TJWc=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HdXiWSRZ; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=HdXiWSRZ; arc=fail smtp.client-ip=40.107.159.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=B0xO6eQMOwrJ8AIHV9y/0Um8k82fmB25YGmyil0VstOF/XW7jlAM3o9D1Q34fHT5nwvCvfutYPzJ16j1bWHqOim2cso+bejyTQsetfZ7lKhxY4EwOThKXSZ+HuaIJ7EZQjuR/BGOqsF6VAYqpDmzGSEQQR3kUHf3RdXVtdUFk3dKg1dCqNXslMBe/DTZeSkIqHnZfZ65kjyH/1ugk7ba7xRWSsZdUNcmVoT21EbPSKFXEkapTCPBxuX6a+YiVXCl/YmH3sCFMRglcO+j4Ts0eW+IxvT37OpCUhHUqc/3NE/6FVzFgouX/J95vDhRhqyOZwp+ilB0IU3Yx1DUPT68bg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbg8S5n/TUgxtY6Qg4n/ixzQvoLItCFtCofQhrBgpfg=;
 b=x0qqn3uwuWFvnu3ZVQDqmK3v29VrYsMHBDr3LHgoI3HjMLFIHDx1LRzFfdWPXv1c3zf0tEe+mm478CSoSqJ0nYfKcQ+YUXZbAEHF7FBDm2g8YfqNcitDsDUeuuqzjXOFnwira+OIU7FXun16i5/qiWeupsdGn8anS/XLkrZjdDcwQh1mahvLrkM7p7EI6yCpwDwOJKkba0eOWW2+Wh1Fz02ReXTiB9izX6QouHlN8hHV8BrYZ/CuVceoOqsRRb+zl5JgBBVNFZ5kMymqzpEEZV15Umq5r4LZuXFpymF34WjmaAu4zjFBApP5gxPKQ2Aq6SdJn14tmolNLN5dhfj6ag==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=vivo.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbg8S5n/TUgxtY6Qg4n/ixzQvoLItCFtCofQhrBgpfg=;
 b=HdXiWSRZpufAavPRIQvXUUbWCEN70H22j9gBXkiZmtwEn2YZh+Rdi4gXH5dU5Fh0FtX8y24Sy11RZboNeKd+0BZFtFUmCDKlmSptnkik89BeojvQvGCAbXoxfoOTdTy+6kbk7LR9DoOqjvhz8rRla9QVBdKeCwoj4QutikEt5N8=
Received: from CWLP265CA0273.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5c::21)
 by VE1PR08MB5790.eurprd08.prod.outlook.com (2603:10a6:800:1a9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.17; Wed, 13 Aug
 2025 11:30:53 +0000
Received: from AMS1EPF00000049.eurprd04.prod.outlook.com
 (2603:10a6:401:5c:cafe::e) by CWLP265CA0273.outlook.office365.com
 (2603:10a6:401:5c::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 11:30:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS1EPF00000049.mail.protection.outlook.com (10.167.16.133) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.11
 via Frontend Transport; Wed, 13 Aug 2025 11:30:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZjDD5eeBX00MhFd7qyquJNMy7EBj3usOXK+vVnOCWx+thaTnMxPI0nxu5YnglE00MKhWG6NMXL0kIV6H8fmcONPUdzah0SjqJgB5Jv8+LpxXGfJIHZBOzUjHj3+9HJtFxv45Hy8n6Dw9cGy7omfp73OE43BQnfOk+4Xx5/KK488ovICdeaMo9dKiET+JxyljGb2R/EIkLcpKslWRnjEmZLm8RYXDAeJGpkO3iheYQDoI/CX13drthoZqrcIQ2+yeIyibEu77DYq0dJm0SZwsshMqYm34jPcrF33HvEVqGiGTz4R+6uydKSkrmcrQA84gI3cSj2PCRtrRZGoZ//WQvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbg8S5n/TUgxtY6Qg4n/ixzQvoLItCFtCofQhrBgpfg=;
 b=wB6SoAXcszyEiuxDh/41kvuMyVIuCbt1UGA6yVxcX3hwr52TP0BSq4shL1Mw0bn58Lilqd+Zull3mDPp8JMJDaodRumRRldLqP28VLdFp9JAjwaPoCgTFH952pFmGtYZUEoiVrZWh42rSFqwTfLAiWfP2M+PW5ch5FKx8as6dS33k2mFERG646m6fMmeLAgyYlb6iuHRnijzIGB0pXy6pGX1vUwa1LKEfsNHkT9XxSadvyvZlCBP/lgTsByb1uMPAtFqYnG5cP9PVi4eG1xgikDxaX06Xih2v5NsMzscH75hHv+VedxmPcUWzutZqeaCkzzdZqD0Q4s+L5KpMCEUgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbg8S5n/TUgxtY6Qg4n/ixzQvoLItCFtCofQhrBgpfg=;
 b=HdXiWSRZpufAavPRIQvXUUbWCEN70H22j9gBXkiZmtwEn2YZh+Rdi4gXH5dU5Fh0FtX8y24Sy11RZboNeKd+0BZFtFUmCDKlmSptnkik89BeojvQvGCAbXoxfoOTdTy+6kbk7LR9DoOqjvhz8rRla9QVBdKeCwoj4QutikEt5N8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by VI0PR08MB10826.eurprd08.prod.outlook.com (2603:10a6:800:202::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 13 Aug
 2025 11:30:21 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.9031.014; Wed, 13 Aug 2025
 11:30:20 +0000
Message-ID: <0a126a70-7515-4b0e-a3a3-1d4ea9c7d00e@arm.com>
Date: Wed, 13 Aug 2025 17:00:16 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] maple_tree: Remove redundant semicolons
To: Liao Yuanhong <liaoyuanhong@vivo.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "open list:LIBRARY CODE" <linux-kernel@vger.kernel.org>,
 "open list:MAPLE TREE" <maple-tree@lists.infradead.org>,
 "open list:MAPLE TREE" <linux-mm@kvack.org>
References: <20250813094543.555906-1-liaoyuanhong@vivo.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <20250813094543.555906-1-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:b8::6) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|VI0PR08MB10826:EE_|AMS1EPF00000049:EE_|VE1PR08MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: b46bea53-69d3-4d21-05ad-08ddda5cdc94
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?SFJSTXFrVlZKSnMvc1VMNkpWOCttdkU2c1ZiTVp4VFNnNXhUMHd3RzgzOWFU?=
 =?utf-8?B?YWczYVk3cm9iRldveWJGd0pEODhyV1AxRy8wOXBsRno5R1IyaGRLYjhwc0Rl?=
 =?utf-8?B?alJkWTYxK29NamxTcEVvSWVUR1VEdkJFWUF2ZktxV2xBc1UvTEpBRDE2T2xr?=
 =?utf-8?B?N1d0NTdzLzNyTG8wOU5QdzNjSmRBMElBMnl3YjJUSHN5QUJvM3IyYUl4OTRE?=
 =?utf-8?B?NzM1QStLSmxFd0ZKREhURlNaTXNtWGV0VU9HV1htYWQxRUJwelc0enBwcU9t?=
 =?utf-8?B?ekNEZXhzcGNPeVBaRTFwRS9SSVdXb3l6dm94ZTJaQmxVTEhKTFJwVk14K3Fx?=
 =?utf-8?B?NnNHcHRMQytuaWdXQ1p1SFJ3cERTR3BHdTR6RmpYOEtJdXVCNGRtYTAvUmlF?=
 =?utf-8?B?TzBXSGdZVkcwSEpIK0svRDBnUEZZTGZNWmVDUjhJM1NzQzNyU1F1RjNnK25Q?=
 =?utf-8?B?RkNrSzhoRHpIdmVrM2R2WExsV0JPbG0rTWZ1QzNLeCtJK2NpaHFNZG9PTXhI?=
 =?utf-8?B?YjVkTUsxNUh3NDc3cEYwbGxsSk92WlR1dWpycmVrK3Znek5jQS9LeStSekpH?=
 =?utf-8?B?WUxMb2x3ZGwvV2RwbmxwdUxqODNja1I4QnN4YUEreVVVa0FYVTJVVi9sZlBU?=
 =?utf-8?B?Zndvekp3eVgrNWdRZDNjQThGRVBhOHBFV0RqYnplTTBPNmJIZDUxT2ZubExq?=
 =?utf-8?B?cnBQaFI5UW5KejlLNzNMUXdTZkU4S3hwZUhSUGlFcGl2Q0dLZXZnRVNDTHVG?=
 =?utf-8?B?empqOHZXM0VvcUg2MmRVUEN1dHFSZnZOTEMrSWJWSEtjazlCcWR3dEJtamJi?=
 =?utf-8?B?YUNCVjRMYy93SXpZc2diWXE5VFRDeFJRRnJuc0d4UFViMmNqdjRxN2ZmYWxC?=
 =?utf-8?B?TjdPMVl6dXRPTUVtM3dsek1DbGh5TnpFOHg4QkVwcUg3Q3VQQzdBZkJuWnFa?=
 =?utf-8?B?T0lKMTJDSEtMUHFBM0FiYU1VVDB0OWdNdVBoazlLUVBIUXh2c21vcnlFN1Rn?=
 =?utf-8?B?VjZYU1U0R0VQUHJFUE5PMnpPZXVLTlFPd3Z0Wjk0dEx3TjR1blBLaEUyaHNR?=
 =?utf-8?B?Q216QTdKanF4WTBoWEpaTi93YWpSVklSRVNwR29NMWg0T1ZabXVtSWFZajl4?=
 =?utf-8?B?QjlrN2t3MXVFV0pwRTdFKzVCWEhOZ2dGV0lIOS95SnZhbUt3aFIxaVB4MnpQ?=
 =?utf-8?B?eTRpb2duV0w3V0h5aUcrUmpQV0YxQ2tUY0wrZGhobTgreHRDbWRNbDQzaDRj?=
 =?utf-8?B?VmhLeUFpM0VSV0hLRWNLZk1Tb2RTMUZkb0NqUy9TU0RYb0UrRmhjV05nVVJR?=
 =?utf-8?B?RUdFaktaRDQvS0FZV1NGNGxjSGZYTUNqOVpISEwyUnJodWYvYmJFbElkdHlV?=
 =?utf-8?B?L29qQnRGSHc4L1V3SUg4UFUxSm1ObkxQaDg2SUo0aEhoNGwxaTZzaDQwVU9y?=
 =?utf-8?B?UjhIeEowcjhMakMxYisxdlprNHFSUExERlFuSDFpbDV0LzZoNmdNVmdJaTAw?=
 =?utf-8?B?V3o2UG9Kb3UranJ1NVJqWWltR09IaGZSM2VScmx3ZVlZUWI4Z2k5TG51UFJY?=
 =?utf-8?B?bHAyZkdUUGdxNzVDeDM0UDZJZDJMSEVWSnpjVGF0L3NyVDhEWmxjVjBaVlBN?=
 =?utf-8?B?dzhWUGdmTkZrMWxOQlJnaTB0Nzk5TGxqUDg3ZGhaOVE5NmE3ZjhsSGxaYTF3?=
 =?utf-8?B?blFmM3VmOHJEOHNBcFVUUWZjV1N0S2tNQ2J6T2NTVmxOOGRxeG5EdXJQL0pW?=
 =?utf-8?B?eFpUc29aZHlzZ2wwSVpzb0crb2dIeXpmbzhyaXNpMHhTK2VhS3VVUGx5eUF3?=
 =?utf-8?B?dFFHNFpPeDZsdTM0WEZpOTByblJBckpQdzVmL1hRYjBTZ2ljMGNIckJjQmFp?=
 =?utf-8?B?QkE4SThhYXJWM3RYTjhUK2hjY2R6SUtwb2dhcTdWWTVQM0psK0EwbGdzc1FY?=
 =?utf-8?Q?FgPuu4OpJ/k=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB10826
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000049.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	0038decd-2764-43bb-e942-08ddda5cc925
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|376014|1800799024|36860700013|82310400026|14060799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVk0WjJ0aUtJaWZ1NzRaY3lRQTFXWmxwVTRVZ1h0OFN5dThGREpsdEVCMS9I?=
 =?utf-8?B?eFRuOFU3Nmp0SmxQUkZIZysxSzZsQjFKS3RsYTZOSHJ5eWdmOTkzMFlQWnF4?=
 =?utf-8?B?cDdYUzh1NW5hWXFJeWZlUkUxbGdEMDQreng4VmpiL2lBUHorQzRLeHNqZTNs?=
 =?utf-8?B?T0JZQ0RnRW1CWks0WGpacHRBckRGUXA3Q1ozc2QxTVowa1pjU2VROUd5SlJQ?=
 =?utf-8?B?THZ0SDRpZGQyMk4rUFM5QnQ0cURrUlJ4MjFMR0hiTHowTlhMM01JR0o0MmdT?=
 =?utf-8?B?TFVabkxyaDMyL2hLcDRvNnZ5M1hSRmlZbmFQYzBydHkvTXFiODdmSDBoZUpo?=
 =?utf-8?B?TjZIN0ZrMXZZeFRveXZYVDZKRnlZMzBiSW5obmdLVmZubmluRGhibkxuS0Uy?=
 =?utf-8?B?MVVoMG9SSHFJdUVFSTZXWXNJb0xOSUxyczdRWkNOc0Q5QzN1aDU5SzdzKzNv?=
 =?utf-8?B?a2FSOFR6cENIVVcySFNoSHhOVDZ0OFQrMFk1bnRLYzF1NFd2S2Rma2RoZlFU?=
 =?utf-8?B?SkVUZStwb0VpazNoT0hYOUpIV21ReFB5b2VjWTRoYkphUXd5VWM3UlNlWUg1?=
 =?utf-8?B?eGJHVWFncVo5b0pCL0I2V2pBamRXVzJzSmxTbS9UTlZnNmJPSGpQL0tybXhn?=
 =?utf-8?B?RzA4MVFiUkNpWXNJSWZtbG5mZHdXRzdwRjE1NE1QNzNYVVNEOE45c1RwUE9L?=
 =?utf-8?B?U3VnajJNTVhFdy9acHBvSW5sKzlzbHJtM2tFVlhoUWE3YzdSNk9POVVqbWRH?=
 =?utf-8?B?VENFaE5xTTY5QWppNUFPamF5WndweGtIN0p5OUxjS1FOY285RUgvWkJLc2dP?=
 =?utf-8?B?NENFSHVDU0tkTk5PVW5iUTFQcU9UNkJxdThlUzZ0dHExSkh1YXFrbmYydjlT?=
 =?utf-8?B?c1l5ckV3WC9vT3ladkU3K2RyYUk0dnRVdjdKcGt3WUhLY2FDVVlDNnVTSDNp?=
 =?utf-8?B?TkVtZ1orbjlQZFNZQklRL1oxVFhRRmQ2MEJwSGgyc3V1dnNvOEZrSG15TUg5?=
 =?utf-8?B?MlgrenBuUXFqWFNZalZkczQxaEFpdzVINndBQ3VQbU0rbUFDOU51MFY4aStB?=
 =?utf-8?B?RXhZVHBWZ3BHNVNOTkZ2blFwanZESzZ4T25aNjlQR3A4SW1GTWZ6OHM4ZlJC?=
 =?utf-8?B?MXQrQm9hTzVaaDAya1VHSUhiOStHYnVORElBc1NRdmRDTVR5MDhBSHNyYXZK?=
 =?utf-8?B?Q3NZSVZGUkhNazBPTmFseWhQSE1TNFVaVXo0K0xRNkhSbkhZU0lhUG1EeG9a?=
 =?utf-8?B?V00ydmNPQ2piQzFkV0tpSGgvUW1HdERpbHo4R2I1UjBVZkZUQmRyS3d0WWpI?=
 =?utf-8?B?eW5qYjBBS0dKM3NKUlppNjNXaExvaTN4NkFWdVM2Y2c1Z2NaUE94aURLNEVO?=
 =?utf-8?B?YWk1cjVoV1U1WWNWd2ZPYnJsWURnclhaV3poYzdPa2lNZWZlWnFRQzdZUERj?=
 =?utf-8?B?ZThsT3RKeGRybVVoL3BlVzdkd2NGYklnalJxTi8vVkIxZm1Pc1J1d0tkTkNx?=
 =?utf-8?B?V1JlbWRZU0tVWGJDL2M4ZmZCcWV5aFZ4a1FQYWZETnNKeGhCRFd0Tk5QNGNj?=
 =?utf-8?B?bk5IaFUvamdwb1VRbFQ5ZWhwZWRLQmd4aTlsc0JodDBsL3NhVXZOcEJOL0R2?=
 =?utf-8?B?akNzNWIzTWU0N1krVjhnQlhRUXdIR1ZQWHd6ODN2Nkp3UnVrcnhMRzdIYjVm?=
 =?utf-8?B?eTkwTVhWbk5zb3ZvRFVkNngwTDVRdnZ0S3VWdmhHTE1oWHNzYkI1cjc4YWNK?=
 =?utf-8?B?d2llQ3F5K0UyU0FCZVRNSWJ6T2dUcHdqN1pvUnhiZU5YVmZtK0swbk8wSUpi?=
 =?utf-8?B?WTlSUGZIWDVMWCtpb2owQjJ4aklPWGVWRHM4YVhVRjFtdkhUVnI5ZWdnbWhE?=
 =?utf-8?B?eUI4ZCtkclNoTHh1Vzgva3dLZWtKbW9iUk8wTTBmYW5XK1RKOWNJNTJta29a?=
 =?utf-8?B?K3RaWmNHZmtxdTZiemlqOUpmM1hUY012dU1lM2Nod2FxSG8zVmdkdlBMRFUy?=
 =?utf-8?B?Qy81S3MrWGFQSW5oUml2WjhGcWdJT3BQRGFQRW9GYVhiSTZpQlpvV1Y5WjE1?=
 =?utf-8?Q?lustAT?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(376014)(1800799024)(36860700013)(82310400026)(14060799003)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 11:30:52.8079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b46bea53-69d3-4d21-05ad-08ddda5cdc94
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000049.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5790


On 13/08/25 3:15 pm, Liao Yuanhong wrote:
> Remove unnecessary semicolons.
>
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>   lib/test_maple_tree.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/test_maple_tree.c b/lib/test_maple_tree.c
> index cb3936595b0d..1433ecc854cb 100644
> --- a/lib/test_maple_tree.c
> +++ b/lib/test_maple_tree.c
> @@ -3562,7 +3562,7 @@ static noinline void __init check_state_handling(struct maple_tree *mt)
>   	MT_BUG_ON(mt, mas.last != 0x1500);
>   	MT_BUG_ON(mt, !mas_is_active(&mas));
>   
> -	/* find: start ->active on value */;
> +	/* find: start ->active on value */
>   	mas_set(&mas, 1200);
>   	entry = mas_find(&mas, ULONG_MAX);
>   	MT_BUG_ON(mt, entry != ptr);

Reviewed-by: Dev Jain <dev.jain@arm.com>


