Return-Path: <linux-kernel+bounces-758077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 993DDB1CA91
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 19:20:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B0E3A4CCE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 17:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399DE296141;
	Wed,  6 Aug 2025 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XjvXTQVO";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XjvXTQVO"
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011023.outbound.protection.outlook.com [40.107.130.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C741CD0C
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 17:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.23
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754500837; cv=fail; b=S8hYScF9gGwL7NzvA73C+RpKlnJgv+voY01R68Ep2ck3794IhT6Kx3OBxet61PdvmiEqA03sR14yVwNS0nUWQEIQfONAVPwk+7iRlZCkg0Yhix1FCOstsx66i+R50cVKYCwcvKNqCRPbMwiqB4jmZpKUKtNsiNAZB4oVh6ziCqI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754500837; c=relaxed/simple;
	bh=6SF8McgI4Y3/8h9C36ZSVNpC9fr7yxdKY0sxHqrbvCE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O7qQxs33le9a/5Kb4Hzj+4Y5DvEoJUFdM2malpAu7CSgasdGqlm6jgFG18X3po4eMOyfSYO+h1KitlQHrL5JTP1VlIJB0SoMWEePkOPZ49Sjfr/GQSYJNF1xc+oQ2921g9vtyJ7aiNBW/pDb6Yu4fgB5pAPfIHhpIWfvpwIAdoY=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XjvXTQVO; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XjvXTQVO; arc=fail smtp.client-ip=40.107.130.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=r+Y/Ew4ct/SsBEOydjTcdN5H37xpWD/EAheNxKoJiAKVL2yS/wa/3luQ/V3vN8yeEY38F5nIfc685XtIyTGy5CtscpQj2x+pGvoLwgymPCN/j3w2QmNyMAvJs09XBR/arm82OZvcxGo9A5Urm7C7gfLBEs5eRIFJDzzI4OPkOJmDwa9l6P7yQOQtZubbcOu5mRqhzTolqJSOplVDUdGMn+L+lExG0732sdc/ilAsxclprriZT8JfYDpx5BJyPD06bMbkARATBpMask0Vs3BK8A6jllC2WQjNx9frvAYcaNcmTSBNzbM4kSjIbjWXC8vtMYm0ikdPwyG9wP912SMg5w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyeQp5xMad6j0CTKQ6u1FPL8F3o+kuUVBpOiQ5TjQn4=;
 b=RbKE3rqsmpUMl0fBZhr7PekKnJInqUNhr3Z7w8bN05JbJYXtWRD3qQKvtksBXhZnmib00L1eCMzIH4hbNj4JpdGaOOx+w9Zo/m+uVigrQWSM2Kx7MfMXBcaBZZMRVIorGVkyOMXCKYzOOhb/pckxKtCrTGWcQUloNBn9IxQ9K9OOE+F8l6mTxmFrr5mTWsiCOAn9V7P8sucmSEEOaqiKxzqcauVb5m1WRA28auv4ZpdSV7RPcrczYWZs3klxmYZYlUlJulrcngZl0uEshDY17SfGvjpjtcXJ4m4Eb1JELASjXN8FWXksF9Jn7Lyp9R0gr9Mt0HxZeurRYUo8+7fRCQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oracle.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyeQp5xMad6j0CTKQ6u1FPL8F3o+kuUVBpOiQ5TjQn4=;
 b=XjvXTQVOCO0Ym/kzw5205qXt31u0T3z+RdhBa61tXQ9FAE01Z1DPozLxYfbS6M5T7Mm3XNXNV7w8PbZ18PdLi3vc0fnfVML55zouerRSQ/9vej2WYR+xaTv1Sxn2ou6YpVa721SkMLJstHst7XWAIwUuHEgohOpquhM5XgXsIX4=
Received: from AS9PR06CA0195.eurprd06.prod.outlook.com (2603:10a6:20b:45d::20)
 by GV2PR08MB8390.eurprd08.prod.outlook.com (2603:10a6:150:bc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Wed, 6 Aug
 2025 17:20:29 +0000
Received: from AMS0EPF00000199.eurprd05.prod.outlook.com
 (2603:10a6:20b:45d:cafe::64) by AS9PR06CA0195.outlook.office365.com
 (2603:10a6:20b:45d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Wed,
 6 Aug 2025 17:20:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF00000199.mail.protection.outlook.com (10.167.16.245) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.8
 via Frontend Transport; Wed, 6 Aug 2025 17:20:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uIQm568eV3xfW85/hsWFN1pYKOhAXNic4kKAM5mV4UQreF2W556wWwwkDkBDe/fst6xdiHMZMEy4mWI4DN3IJzl4xiJKXArJOfsg/+B6A7OidMbA3S7i2fpxr9ZSe0Ama16RmmcVuED3ZzwBq/9OriJR6AyPHMUzuRDEJl06vdc7Xkq8rWeYTxfGu3IOjM4dm6Q0fddiZpTjtqNS8HBi8/1S50f/6NbwAu8bVe+5C1zGZ0l6h82X376ABWAkMiQbzYLYhvNLNX2RQB3GVFOoCmAcHL08dzqJSqx6yiF/cY0ZyovuhUXU2uaGGXJYDjP5R0MDp9oXwqR09U7RvC7QZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OyeQp5xMad6j0CTKQ6u1FPL8F3o+kuUVBpOiQ5TjQn4=;
 b=jAThgTDRZegLaFpzUP1UtH2W212l+Ds7R3E9aZWk4e3Dh2yuxRegVUcDm0U03Qpmuc3m2sIiD5RcPC/+VUz0JC72JKleoUuC7DssWVZlr7mJuQ23nl0fbQmzeJG77Wo8F9WWmgIXRSx/eCZJ7KFU/m4UWfPtYjpACt9AqHE7in6ZX8cl16mbz0TWvkcj2kSHGvJlD7Oe+8AdktkWn9QPGIZrwFeBbxu4JPw7EN7SbhB16fgOr3292omnja7Z+ttDCKlnV/eCUd15I70GkBM7FT1ukEu0BvhQ0LX1cX9Vo7L/BQ6Url2JGnt+XbH7CiHB0scicJomp7JPX0FItFgYjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OyeQp5xMad6j0CTKQ6u1FPL8F3o+kuUVBpOiQ5TjQn4=;
 b=XjvXTQVOCO0Ym/kzw5205qXt31u0T3z+RdhBa61tXQ9FAE01Z1DPozLxYfbS6M5T7Mm3XNXNV7w8PbZ18PdLi3vc0fnfVML55zouerRSQ/9vej2WYR+xaTv1Sxn2ou6YpVa721SkMLJstHst7XWAIwUuHEgohOpquhM5XgXsIX4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by AS4PR08MB7580.eurprd08.prod.outlook.com (2603:10a6:20b:4ff::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 17:19:55 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 17:19:55 +0000
Message-ID: <78922f87-dc5c-4652-a5c3-869d1bca1d88@arm.com>
Date: Wed, 6 Aug 2025 22:49:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-hotfixes-unstable] mm: Pass page directly instead of
 using folio_page
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, david@redhat.com,
 willy@infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 catalin.marinas@arm.com, will@kernel.org, Liam.Howlett@oracle.com,
 vbabka@suse.cz, jannh@google.com, anshuman.khandual@arm.com,
 peterx@redhat.com, joey.gouly@arm.com, ioworker0@gmail.com,
 baohua@kernel.org, kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com,
 christophe.leroy@csgroup.eu, yangyicong@hisilicon.com,
 linux-arm-kernel@lists.infradead.org, hughd@google.com,
 yang@os.amperecomputing.com, ziy@nvidia.com,
 syzbot+57bcc752f0df8bb1365c@syzkaller.appspotmail.com
References: <20250806145611.3962-1-dev.jain@arm.com>
 <acee52bf-4f19-4e85-8d69-15d6cda54e95@lucifer.local>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <acee52bf-4f19-4e85-8d69-15d6cda54e95@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0081.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::8) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|AS4PR08MB7580:EE_|AMS0EPF00000199:EE_|GV2PR08MB8390:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be86c86-bdeb-42d2-8de4-08ddd50d8a1a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?SVFlU2trRUwvcERONzkrODJrTm90Q1BrbVR5R3dUWjQrSG1JbmpwRVdOUEJz?=
 =?utf-8?B?Sm03RzlGN2JUbUk1WGoxNDYxalBIRmsrWC9qYWlueTM2TlA4L1h5bWhRQ29Y?=
 =?utf-8?B?TTR4ejRyMjlMazNjNG9DTDBUSFc1ZzB1a3p2V2IraENvd2tVbThZSWc4SG1a?=
 =?utf-8?B?andXUlYrVTB6N240cXdWN1B6QXYwVWRrVlhTM3JhNUhvQ1dlSlh6MzlCUmdM?=
 =?utf-8?B?OG9IVHIyU0NjSkQzUUIwQ0kvcFpsWGhyM3MvOHZhUGxlY1J3dldON0hOdWVa?=
 =?utf-8?B?UE8rUW96Mk9SaFpFYzMzL2Myakd0YWVab1Z6Rm9BYW5yWjBIQXVXbmNGMlRu?=
 =?utf-8?B?SUIvYThBQ2Y1bjVzRVNxaUswbDVVL3RLWkwwSkhmSnNGNFpBNHdWclk0eHV5?=
 =?utf-8?B?ZnltVmlqS1NpOVJaL0s0UDZFdk5OVzhNYlppcTZ1QWlaMkpoR2hxNUhreXJq?=
 =?utf-8?B?MDFIN2dsS0VzcW5BN3RHd25PK21hNTZMK0xGU2wzWWxNYkVvNElLbHdjU2xT?=
 =?utf-8?B?ckE4ZWNTZFBTVDg2akc1TGtPVXdZN2ZNWUlnYjZ6ejlrTHVaS205OE4vU2Fz?=
 =?utf-8?B?TllYWkVWQmplelBGRjdYUUM0Zm00ZDFsWHhCWWVXZXBjOTRjZTlTRVdIOFlq?=
 =?utf-8?B?V2hzYnI2MW1iSGFnNlBsS0hRanJodkx3c28rV0kxVG5KRmpRaG4vQjVoQmxG?=
 =?utf-8?B?eUZRNzJCem9qbndkM3k2RkZRd0VIRFBOQzFnVmJ3Uk94N25FZG13RGxCQzNn?=
 =?utf-8?B?OUJPUnVVQnVUTDcvNEV2UjVDZnNjdWxQV081eklnOEFkY09yNUpDaG1pb3dP?=
 =?utf-8?B?NEsrbGIrNzF3NVgrZ29qaVVyMERScDdWd24xRXBRVGVxQWNyMGxsUGFyaEIy?=
 =?utf-8?B?UVFYM1VpSy9pck9mVmxyVUZWRmllTHV2SW16enlFR1NqZmRuekgzNmRuRkRG?=
 =?utf-8?B?WWhBR2EzcVdZU0d5blM1WTBZcElOajBkMExrYTl4eHozL1hjODJFT2xVdDdJ?=
 =?utf-8?B?Q1hHdmFCTm84aW5BWi9od2ZyclVGSTVLVzdzSWtJajk5OWgvL21ST05JVlRE?=
 =?utf-8?B?UG9KanNUUG9DL2lQTS9QbTZPL2FSQWxFOVNabGlzdUJyYStVMEV3RHZEZ0dX?=
 =?utf-8?B?TG83K3AvcGwzY1YyZVA5blJTMzRCZGtkSXJTMHFqbHBST205RDNsT25EbGVG?=
 =?utf-8?B?RjJ2V0ZsaUI1NDNnQ2FyQWpwVDFxci9tdkUzMHM3K0ZSeTc0U1RCQ29SbFlB?=
 =?utf-8?B?OWFMdjZxN0ZCS29STmszVFpQYlVnWWh6NGV6b1BNL2luZllIc2RXaFhiaStP?=
 =?utf-8?B?US9oSWpUaFNoN0srUlowamM5bTBZTzc4SFlvWlF6RXpkbjNHZTdGeGxZWVZG?=
 =?utf-8?B?TjZXbXc2QUQxOHJQWUZEaEQ0TDNBNFdtaVhqS1RBOHozSDRyeGJCVEZmRmJ1?=
 =?utf-8?B?Q3ZqMytDd3AyZHF5anBDSEFlVUExQ0ZTWk1jNXJYYlc5Mk9FczNXK2FwOURt?=
 =?utf-8?B?cVpOZi9La0RHcVB2K0FYVkZVakZmR3BURTJOTHpjSy8vdUxLZlZMdjNEN20x?=
 =?utf-8?B?ODdiS0tFQkgwTFNpNDJYeVJSVkpna1hqelI1MkFDandaZ0tBZlVoTFV2bHls?=
 =?utf-8?B?bjdyYzRJYjVoOVFteHhMNHJwc0FDdjlpTXBya0NLaFIxanZMa0NwVDM1RDFL?=
 =?utf-8?B?UGwxdzV5MVowMzB2YXRpWVFScnFpby91a0QrU1d3WThaWHdObFJrYlE3TWR1?=
 =?utf-8?B?eG10a29FUVJEdmFXaFh2YmIrTEtRMUg4MmQ2RVNYOXM1K1RBUXdvL0lrY1Ra?=
 =?utf-8?B?MkFuL0dkYUdacWlXK0FrRm9LUXlrQU90cU9rNzEzcGZGakY3VUFHSXJNMnlh?=
 =?utf-8?B?ai9xSmpGS2pHWmtGNUhiT08rUHpMREx0SDVnNHJZaExRaXc9PQ==?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7580
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000199.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	ceef3f17-fa33-4566-966e-08ddd50d75ee
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|14060799003|35042699022|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L0Rid0k4QlJNVWRka1gxdUtTNHREc3lZalhKR0ptZEJiOVNISExQRWZOUU11?=
 =?utf-8?B?K0ZRQkFvN0lRWXBqYWY2TXZVS2JHOThwQjlEM0pUcEpEdkFLNCsrb0FZNDRp?=
 =?utf-8?B?dW52WEJmczdWTkRRWVJUQkZnSmh0SmxDOFZ6MU5uM014bUllK0lYWVJtTWdF?=
 =?utf-8?B?M0RLN1dJZEJLSnBMeDMramJPWURvQlRBcE5oYVN0ZGEwTEtBenVMbzlybnll?=
 =?utf-8?B?cVFTNFZoL1lkRVVFdlgyS2Uyb1N0OS9vLy9mbVROTmFZZTN4UllWeFF1K09i?=
 =?utf-8?B?clBpZENTN0VLZEhqTXlYb1ViWXQ1VlZoOG9LY1RxRDJPRWRQUTlwZEs2STVP?=
 =?utf-8?B?VG1JRWgrVk0zbVJ0d2FNNHNEOStlbTZaMVp0UHBVOVF5OUVyOW02L2dvZ2h3?=
 =?utf-8?B?bld5MEpOeFdFVlUxeHU0ZE9yZ0FwYitWb0dJYW9yM2txdE9VeHlPK0NhRVVW?=
 =?utf-8?B?ZlRNT2c4dGFwTk9nZm1TOEZqallzWG9iSUdJaWd5Nms4NG9DUDZpdmdJNXVt?=
 =?utf-8?B?czNVaVJIcWpOaXJaR0dmYWxZTzdYSktOSjBVNllqWklaYVU4RTk1bEZLTytV?=
 =?utf-8?B?RzQyVHJuUVpyR2R6bE5JMlVBeThhM3hVY0RsMWROc0NRQ09XOTJYR01LSUts?=
 =?utf-8?B?TTd5SFVQTEtnejFwcW92SEVIWFA4dGRYb1RBN25QTklHL0Y5VjRZV2RPNzNR?=
 =?utf-8?B?K09TMEZRaTdLeEk5MC9nd20zVjZCT05rK2FNYjdFTHY3SCtndENFWFNORDRw?=
 =?utf-8?B?RGwvenpoWG5nK212bUVzVEVTSmdlMzdIMmxTRE5kdWFoVXpqNURZbW9mb2JQ?=
 =?utf-8?B?WTQxaGtLQzB4QzBKSUwyZ3FZUFZkQ2JXTlkxbHdsZkV4OFdLVFNlRGkzU3g5?=
 =?utf-8?B?dDh4aWUyWGdxbURkTDZwbm1vc0hDT0JQWlpjaXh0bklIM00rQXZRTC9RTS8x?=
 =?utf-8?B?RUFFcnRXbG91Zlovb0ZrT3NxOUo1WUN0YXlpWW9KN2J1U0tnR2I2amNra3hy?=
 =?utf-8?B?SDd5eFQ5OEFoQi92c2tza3NwYkdONjdacUljQ1dkZXVmSE1XaTBiRUlrU2dR?=
 =?utf-8?B?NERBRFB3Y211bGFmTmZCODVCV2h0QXBBdlk2YW9wcXIxQlRldlhHa2JyR295?=
 =?utf-8?B?ZkRXMHpRYk44aEkyTkh4WFNYb2xKSC9RcVVMNFIwcEFwaE5zTlc1cFMvSjVO?=
 =?utf-8?B?c0JrTm5ZSHhvckY1TWFhcnUxTGk1bE9BUWRrWEpGUCtnM0UrOWVaS0JSclI0?=
 =?utf-8?B?UlJMOUJFQlkyZkZ4MkJRbTczRUFPSDZ6VUdhZ1ZhR09vWmpwbDdqMW9uTjNn?=
 =?utf-8?B?WmNWeDVtYWJyWi9Za1pHcnBVNk1zTWdXOXdZdy9FdEJ4Mkl0akh6N1ZIa2pl?=
 =?utf-8?B?Nlc1aHFqdGRpUlByRkVpSDk3c0Q0UDNHb3lLeWVCN21sTTNENmJGaUhkV0Y1?=
 =?utf-8?B?TVF6dkxBWkg3ZTg3WUpWSFpDdkJJVDhISStoWHAyQ3pXWmNaZmpQcGsyQWYx?=
 =?utf-8?B?aHhIWUVycS96eS9keXg4UE41T1padUljWkh4ODVObkF4N0t1UEcwdTQ3K0Nq?=
 =?utf-8?B?Z2lJdHN0U0VIZnprbzdXMmNwSDdpL0NleDBWMlplZmNqcHJZbHpQemtOcHkw?=
 =?utf-8?B?aGFmTkEzRUlRS04vbEIrS1I4UkxlWjVQSzduTkpIZTF6d2JvS0NZbVNnTkE4?=
 =?utf-8?B?S1M1cFc1cERBNWNxWmhJY21QeEdRWFdCakkxVUtLZkZIeFNML1oxYkRSNWd0?=
 =?utf-8?B?U0ZrOXJuV2JyOWVCUVVDWlJ3QllYUE03ZlJtRk1BTnA0ZTdoZ2J1Sy9KbXVI?=
 =?utf-8?B?SGNzQ0hublhBcE9IbXFZRTdqMGZvdkM1RjM2djVTQjV3SDBqdUtaTzVGNm9x?=
 =?utf-8?B?bnJQY2tDZkJ3cmRzTFkzbUNRck1EaUkxa3ZxQXBSQWlBTGt1T3R4TlFQaDkr?=
 =?utf-8?B?WEljRGNhR3YvQmpTOEQ1UFNvWjR5bGk1TXdJLzR2RllGL2ZqcmIyWXVXMmlD?=
 =?utf-8?B?R2tzWHRGZFF4NmxZeGhLd2pneGdKM1JhQmljc3g3SjVWdVc2M25ab2x4MG5l?=
 =?utf-8?Q?3cHdy6?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(14060799003)(35042699022)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 17:20:28.3669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be86c86-bdeb-42d2-8de4-08ddd50d8a1a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000199.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8390


On 06/08/25 10:10 pm, Lorenzo Stoakes wrote:
> On Wed, Aug 06, 2025 at 08:26:11PM +0530, Dev Jain wrote:
>> In commit_anon_folio_batch(), we iterate over all pages pointed to by the
>> PTE batch. Therefore we need to know the first page of the batch;
>> currently we derive that via folio_page(folio, 0), but, that takes us
>> to the first (head) page of the folio instead - our PTE batch may lie
>> in the middle of the folio, leading to incorrectness.
>>
>> Bite the bullet and throw away the micro-optimization of reusing the
>> folio in favour of code simplicity. Derive the page and the folio in
>> change_pte_range, and pass the page too to commit_anon_folio_batch to
>> fix the aforementioned issue.
>>
>> Reported-by: syzbot+57bcc752f0df8bb1365c@syzkaller.appspotmail.com
>> Fixes: cac1db8c3aad ("mm: optimize mprotect() by PTE batching")
>> Signed-off-by: Dev Jain <dev.jain@arm.com>
> This looks reasonable, fixes the problem and compiles/works on my machine so:
>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks.

>
> This badly needs refactoring as 13 parameters being passed to a function is

Which function are you talking about?

> ridiculous, but we can do that later.
>
> Let's get this in as a hotfix asap.
>
>> ---
>>   mm/mprotect.c | 23 ++++++++++-------------
>>   1 file changed, 10 insertions(+), 13 deletions(-)
>>
>> diff --git a/mm/mprotect.c b/mm/mprotect.c
>> index 78bded7acf79..113b48985834 100644
>> --- a/mm/mprotect.c
>> +++ b/mm/mprotect.c
>> @@ -120,9 +120,8 @@ static int mprotect_folio_pte_batch(struct folio *folio, pte_t *ptep,
>>
>>   static bool prot_numa_skip(struct vm_area_struct *vma, unsigned long addr,
>>   			   pte_t oldpte, pte_t *pte, int target_node,
>> -			   struct folio **foliop)
>> +			   struct folio *folio)
>>   {
>> -	struct folio *folio = NULL;
>>   	bool ret = true;
>>   	bool toptier;
>>   	int nid;
>> @@ -131,7 +130,6 @@ static bool prot_numa_skip(struct vm_area_struct *vma, unsigned long addr,
>>   	if (pte_protnone(oldpte))
>>   		goto skip;
>>
>> -	folio = vm_normal_folio(vma, addr, oldpte);
>>   	if (!folio)
>>   		goto skip;
>>
>> @@ -173,7 +171,6 @@ static bool prot_numa_skip(struct vm_area_struct *vma, unsigned long addr,
>>   		folio_xchg_access_time(folio, jiffies_to_msecs(jiffies));
>>
>>   skip:
>> -	*foliop = folio;
>>   	return ret;
>>   }
>>
>> @@ -231,10 +228,9 @@ static int page_anon_exclusive_sub_batch(int start_idx, int max_len,
>>    * retrieve sub-batches.
>>    */
>>   static void commit_anon_folio_batch(struct vm_area_struct *vma,
>> -		struct folio *folio, unsigned long addr, pte_t *ptep,
>> +		struct folio *folio, struct page *first_page, unsigned long addr, pte_t *ptep,
>>   		pte_t oldpte, pte_t ptent, int nr_ptes, struct mmu_gather *tlb)
>>   {
>> -	struct page *first_page = folio_page(folio, 0);
>>   	bool expected_anon_exclusive;
>>   	int sub_batch_idx = 0;
>>   	int len;
>> @@ -251,7 +247,7 @@ static void commit_anon_folio_batch(struct vm_area_struct *vma,
>>   }
>>
>>   static void set_write_prot_commit_flush_ptes(struct vm_area_struct *vma,
>> -		struct folio *folio, unsigned long addr, pte_t *ptep,
>> +		struct folio *folio, struct page *page, unsigned long addr, pte_t *ptep,
>>   		pte_t oldpte, pte_t ptent, int nr_ptes, struct mmu_gather *tlb)
>>   {
>>   	bool set_write;
>> @@ -270,7 +266,7 @@ static void set_write_prot_commit_flush_ptes(struct vm_area_struct *vma,
>>   				       /* idx = */ 0, set_write, tlb);
>>   		return;
>>   	}
>> -	commit_anon_folio_batch(vma, folio, addr, ptep, oldpte, ptent, nr_ptes, tlb);
>> +	commit_anon_folio_batch(vma, folio, page, addr, ptep, oldpte, ptent, nr_ptes, tlb);
>>   }
>>
>>   static long change_pte_range(struct mmu_gather *tlb,
>> @@ -305,15 +301,19 @@ static long change_pte_range(struct mmu_gather *tlb,
>>   			const fpb_t flags = FPB_RESPECT_SOFT_DIRTY | FPB_RESPECT_WRITE;
>>   			int max_nr_ptes = (end - addr) >> PAGE_SHIFT;
>>   			struct folio *folio = NULL;
>> +			struct page *page;
>>   			pte_t ptent;
>>
>> +			page = vm_normal_page(vma, addr, oldpte);
>> +			if (page)
>> +				folio = page_folio(page);
>>   			/*
>>   			 * Avoid trapping faults against the zero or KSM
>>   			 * pages. See similar comment in change_huge_pmd.
>>   			 */
>>   			if (prot_numa) {
>>   				int ret = prot_numa_skip(vma, addr, oldpte, pte,
>> -							 target_node, &folio);
>> +							 target_node, folio);
>>   				if (ret) {
>>
>>   					/* determine batch to skip */
>> @@ -323,9 +323,6 @@ static long change_pte_range(struct mmu_gather *tlb,
>>   				}
>>   			}
>>
>> -			if (!folio)
>> -				folio = vm_normal_folio(vma, addr, oldpte);
>> -
>>   			nr_ptes = mprotect_folio_pte_batch(folio, pte, oldpte, max_nr_ptes, flags);
>>
>>   			oldpte = modify_prot_start_ptes(vma, addr, pte, nr_ptes);
>> @@ -351,7 +348,7 @@ static long change_pte_range(struct mmu_gather *tlb,
>>   			 */
>>   			if ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) &&
>>   			     !pte_write(ptent))
>> -				set_write_prot_commit_flush_ptes(vma, folio,
>> +				set_write_prot_commit_flush_ptes(vma, folio, page,
>>   				addr, pte, oldpte, ptent, nr_ptes, tlb);
>>   			else
>>   				prot_commit_flush_ptes(vma, addr, pte, oldpte, ptent,
>> --
>> 2.30.2
>>

