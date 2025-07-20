Return-Path: <linux-kernel+bounces-738261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B73E8B0B67B
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 16:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CED81896C69
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 14:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A7B219A91;
	Sun, 20 Jul 2025 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KEUX6pWG";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="KEUX6pWG"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011027.outbound.protection.outlook.com [52.101.65.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE4FF9E8
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 14:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.27
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753022408; cv=fail; b=YB2Zif3rjysJs0z8Cs0ucIEF51xTPmDqhrAuDmCJhT3ogm4Wo8KRMdv9FQwZb/ygVWagSBJVG92mEdr8XKhD4kbNkMqlzRmYdEyHnkyHhkeMtJafKyCMZxeGsCGM9DWEXBWASlri9KzehjtwTp4cF1Ob+CySbGfnM559MNWlUs0=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753022408; c=relaxed/simple;
	bh=0YlBqmOtvOvLq5e8ChYddfUZeD4WoCmAMlUbeMj9438=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nf2dQMaScHz/Q7Cy67U/4u1MYVypwj6eB4DYcSnAQt1CEHC/naRAUv2H1pW0E6I+LY2vpSoQHqToPJs2NyAlE5EHR6L8sJjELVjBMd2SgB5o9pL0a55WK6eqxH7c3qaNSCIll06UOl4RURSex7Hdq8SdO4hQ4jKzgvZNvmom3OA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KEUX6pWG; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=KEUX6pWG; arc=fail smtp.client-ip=52.101.65.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=gR3RHumupITvZoDTigKBtcVaf/2c8GiKote+JUj/BMazFqXs8MD1z3pvsk4UvEY5JZrkgrjgywqycAv8/Fyq0BbndeNA68ogDM1/YrXFW5BAdsB/n6XA9rd5x+iUImV5dwvp0b80zlTeSVXygbawkJcIL2IL9oajuWevsJUivEX7N2dMelk1rC1K+VkmDfCQFWvU0oIdYtaMRzFn05q7GkkzbNOhxwkT7lOSFebH8HXpFWWK3wbbX+NXx1B8fZVtewVNPLCqhGmmrIAVxcCbGJ/l/Un8NsANttQDaNcY/1zN1ovgjf/axcywz/5GJkzch1hjecxoU625/MfhxypAwg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLAIR6AkL9PrGQVarpvvyJlYi41VGs7vNzow3km6QSk=;
 b=MknH2GNK0hidp4IvQYi/BFUUsQtZ8cs46+r2Fy1CnMmyNC0IGUsUNKenK/8o+lCxk6d18Ga1dfvduB0B1M+P9tam4nID/xEMI9Qa4B+kKZExpoZwciAwJQPVP1wmdGjAC0hXnK0aWQ5pQAA6Xg24q3bEKzDHaVI5WVvF3beAI8LktBt6UYzy/w7yHVSYQZBigWg3jdIVZ0wU3LJwUU3u3ZDC2aSP6pClwvlaY/RiTOEoV2VtyyjNmTph8wq9MwEDYengjjGKKBKDfz4VxCqtDgb6c5dnSaPYa2CnTdm4KRPpBIX4O/uWGD0o5KWSmaamFNH1+w6Jq+BcD5/zNkQ63g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=oracle.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLAIR6AkL9PrGQVarpvvyJlYi41VGs7vNzow3km6QSk=;
 b=KEUX6pWGnJs/vXAGDqLZl6GHxVmDX7oZQTnXIdHBRQEx3VRDaYk2slrTpsFiROIZXCytFLxKrED5HRfWobYXTkkA5Gux9JJJFNaBlgM12oqwwjSJr+MoSIzyChDqReeGhC8OCwWDbcm6hHcW5VyO0B9VQJ8Ffiu3fJL7Bs8M7Cs=
Received: from DU7P250CA0025.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:54f::14)
 by GVXPR08MB10473.eurprd08.prod.outlook.com (2603:10a6:150:156::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Sun, 20 Jul
 2025 14:39:57 +0000
Received: from DU6PEPF0000B622.eurprd02.prod.outlook.com
 (2603:10a6:10:54f:cafe::72) by DU7P250CA0025.outlook.office365.com
 (2603:10a6:10:54f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.23 via Frontend Transport; Sun,
 20 Jul 2025 14:39:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DU6PEPF0000B622.mail.protection.outlook.com (10.167.8.139) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.20
 via Frontend Transport; Sun, 20 Jul 2025 14:39:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RXc5m9nAs+PK5XZPK2p+kLxoODPk4efGgUg9g+4v5W9Oqapg5CJ6erDtPDbvgoBCyVoWmeOBQUoyjcyKNSCPztkEhB/ors13vALgCR59Z3SrFAoLmg6/a6LASkPJqENOWAS5578kU7S9pIk6M8OKmE+Ysoi0KuS0qXJy+h62JPeyp/Tt0Y7A6A+Zw6P5ApBknNIS19/AZ4nt3f8nHy4+GVJOCDrS3HzB2CPLZROvHJl+R4JnmM30d2CmwrtmFOp8azxVtz49nTI2E0txZXXhhcC8YXxwwxyBwWpHeB7sSXndXfhb7oBBhAz+r5vDcTHqMbcyxG5efsqWTjEaCVgMPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nLAIR6AkL9PrGQVarpvvyJlYi41VGs7vNzow3km6QSk=;
 b=h4cqrgIU1piTjtP9hOi5LP+sG/AvQ4Yj9TUZW5ZSvae9lLNL7RWP+nVGZ+K05pQuGVg5xh9WdqykkA16mSKm35cT3LVbnD/sz786wmTgOj/lj61MYpK3XpC8ifmAs47N7hXlOugpsGzdN+veQ5kTOMNX91npgKp/s+nkRRsFVwzVJmwVjZ8eob03DmHP+SwpcTSunhiOH3ECUdmXZmk5qlduiCOnScX3kM+3r8aGYC90D2pEqy0ZHAzz/KG3ZrsHaxJfSqzKtUlF1v3XuxmHr/PJcGBvK30/oNFSe9IxLyP7vOiFeCXhLlDXNxO3WSV6xCMSZVQXwFfCwSST4ySbmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nLAIR6AkL9PrGQVarpvvyJlYi41VGs7vNzow3km6QSk=;
 b=KEUX6pWGnJs/vXAGDqLZl6GHxVmDX7oZQTnXIdHBRQEx3VRDaYk2slrTpsFiROIZXCytFLxKrED5HRfWobYXTkkA5Gux9JJJFNaBlgM12oqwwjSJr+MoSIzyChDqReeGhC8OCwWDbcm6hHcW5VyO0B9VQJ8Ffiu3fJL7Bs8M7Cs=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by DB3PR08MB10335.eurprd08.prod.outlook.com (2603:10a6:10:435::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Sun, 20 Jul
 2025 14:39:23 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.8943.029; Sun, 20 Jul 2025
 14:39:22 +0000
Message-ID: <c14f174f-29a9-4b39-bfe8-ac96d1c2fcdd@arm.com>
Date: Sun, 20 Jul 2025 20:09:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] mm: Optimize mprotect() by PTE batching
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, ryan.roberts@arm.com, david@redhat.com,
 willy@infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 catalin.marinas@arm.com, will@kernel.org, Liam.Howlett@oracle.com,
 vbabka@suse.cz, jannh@google.com, anshuman.khandual@arm.com,
 peterx@redhat.com, joey.gouly@arm.com, ioworker0@gmail.com,
 baohua@kernel.org, kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com,
 christophe.leroy@csgroup.eu, yangyicong@hisilicon.com,
 linux-arm-kernel@lists.infradead.org, hughd@google.com,
 yang@os.amperecomputing.com, ziy@nvidia.com
References: <20250718090244.21092-1-dev.jain@arm.com>
 <20250718090244.21092-7-dev.jain@arm.com>
 <5c993cf6-13c8-4420-bd78-706ea287fb28@lucifer.local>
 <9377543e-3b92-443c-adb0-bc3227ea994c@arm.com>
 <43ac6e1d-e8b4-49c1-8216-af523e120630@lucifer.local>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <43ac6e1d-e8b4-49c1-8216-af523e120630@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0167.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::15) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|DB3PR08MB10335:EE_|DU6PEPF0000B622:EE_|GVXPR08MB10473:EE_
X-MS-Office365-Filtering-Correlation-Id: f3fe7de2-f11a-414e-f81b-08ddc79b4bd9
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?WDhxZ1lQeU4ySnFDeW41ejVXQ3NyQnV1aVg5N2I1VlZWVUFHcXBUdHo3VXZH?=
 =?utf-8?B?TmtramRaN1JLV3JZZ1cwdSttdzRMR1BWOXR3Tyt6Z2tBZmZiTHc1blpjcktZ?=
 =?utf-8?B?aTBPTjdmVnlJbUR1Yyt0WkpyT0dzbmVNNkk0b0xVYStNU1UxbGFIQVhWeGsr?=
 =?utf-8?B?NXROUExQeFBpTzA2M0RqeGI0MUgvOENHdnQ4bUQvTURlWDI5VHNuU1pIZGQ1?=
 =?utf-8?B?bFYrVlVFb0Eyci9TSEhubzNZRi9IS01rRTVzU2NDMnlTczE3MDlXQXlOTFZR?=
 =?utf-8?B?Y1lEeElmd2Z0Z1Awa1pxRlhpbzBLMzJCbHh1MURFN2FLcDd3NFJibU04NzhE?=
 =?utf-8?B?djEwZ2tkUnpxaFJ2TFFhSXJTWHBWMEZFTkp1Z0NxVkJhSGU3V0pFRnkxTXFi?=
 =?utf-8?B?bUl4bWFNbW4zTUV6eUpHNGNTRllVZmlBdHR3RmpuaVlqOGlwdi9lbE9NZDFF?=
 =?utf-8?B?aEFjLzllaE4ySXM0QXRFM0NabjhxeWZuenlzcHVZMXJoaU9nU0EralorWkY0?=
 =?utf-8?B?NGYrR0xmRmRBSFBMcFVRU0lOQnJZblpkL3lDWWY4aTk1bkUvMnNCS0VSeUhO?=
 =?utf-8?B?Z1RlWXVSRi8vRVV3ZnpPRnNTakhuVmIyRzAvQlhMZUFibE9DaW96MHcwR2Ez?=
 =?utf-8?B?NlFybU1zRnRpN3ppeEpHZXUzeGxZWDNEZ2g2NTRWYWM0MWlvS1RXYkR0eVk3?=
 =?utf-8?B?UWF1ait5djZhZE1DSFVBa2pDOWJrM3M5ZmhLb0J3dmhjYVo2ZlhXTUFySGR5?=
 =?utf-8?B?V0V6RlR2WnBTcUlZeVVmak9oTmZOMGp4U2JpZm9YMTdTWlNlbitZcjdWTGNa?=
 =?utf-8?B?T0h3eHB0QllsYVVEbklISCtwNElWT0VhNno3anlISmVvaHRKZlFYN3VhbHpw?=
 =?utf-8?B?bldyRFo0YTZqblZsTGxLcW1UNXZ2bE05dmoyVnFyb01mOERUeGdsQ2FaeE4v?=
 =?utf-8?B?TlROUExQZGx3U2RUWjNhaU94cEpQd0svY0NseW5FR3JiNk5heGtmQlVZcHUz?=
 =?utf-8?B?ZldIdU1jdmpoSjk2ZlBjeWhXS2d5RHZaMzB0NUtseDAwVlRlWjFFOGN1Y3Zw?=
 =?utf-8?B?dWRPemFmaVJzYnRRa0hneldBb25VUGhEVXFyaXFFVGU5RndwZkRnNmcvb25q?=
 =?utf-8?B?Vi9RTnc5cFBkSDV1UkRudmgrS1dUblNnVThqcGZUL1hsQkladFlETVBKbStm?=
 =?utf-8?B?YVJMbDk4RGNxSkVQMVVDZFN2NXpFakhHcTh1SW40MTBJcHpRSi91Q3JHcFJk?=
 =?utf-8?B?ZWR1eXNlOXlmT09iMGdWUXliVHdkSlA2c2tQUTNVaU9lM25pQTFwSG8wMlMr?=
 =?utf-8?B?UGM2UERLNW4zN1Z3SHEzSDFTUkJkWDNoTDJrNktsUXVnM2V2cDdSZmI4SHE1?=
 =?utf-8?B?WGdWSmFQNkFYK0l1ZFBBemRNSGJEakx6ZzB0Q1hXK1RTNzVFNS9EYnBkSXFa?=
 =?utf-8?B?UlhnSkFwVmZvN2IxaTF1Wmp2UDJWZlZFbVhQbTc3SEpjd3JRb1BkNzRvdUdO?=
 =?utf-8?B?S1JJSHJMNmxxeTdEU2pTOElKK2hqVTlKcWxqeDZtRWRTdmZmUm03QzQ2Wkk0?=
 =?utf-8?B?WUVNL016NXd2UmtTZFc2RjNsZGlrUXRtc2RHb2VVT1NoQXVZeUg0aXU3Vk5B?=
 =?utf-8?B?VnlUc3VocEJuNVJMck5waWZqUVlMYjdhempncWZEdkxqRjZieTRaSmpvRzVD?=
 =?utf-8?B?QmtnbXA0UWJnOXIwdnVKZ0lKNUtqYjZ4RWdyZ21mZzJ1Z29VV0UyYVU1NDhi?=
 =?utf-8?B?RSs3T2VqNlVIT0hKeXlON01KWHRWbDJCZzVVVE0ranVVVzZNOTZaeVNqVmty?=
 =?utf-8?B?ZUhjbzVVYndtcEpSK01NYnNpcXlyVkxtTzBwTi9tOGhqR0lxTHNIc1hCaHlr?=
 =?utf-8?B?bEZxbTBGMkFkTzk4eGVxN1pxNTJwMW9CeUJMK1R2ZmNWbURIMEFsMS9KaGR0?=
 =?utf-8?Q?ZHNXb8F1Js0=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB10335
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000B622.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b12c13c3-0aea-49f1-544f-08ddc79b37bf
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|14060799003|36860700013|82310400026|1800799024|35042699022|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0JOOXBKR3dPTThMUG5PZ1hrVm1UR0NBam5WVkNPaExtR3VtV0JuYjd0VUhw?=
 =?utf-8?B?aFg5cTVWa0g2YkEzVUV0QlU4bzEwU1ZOMWNvOEtJdE0wTUFxdlNwN05SbkF3?=
 =?utf-8?B?eUNtdG9sK1EveG4wSlVtV2paaGluaWZqRi96WEJ6YkNPNjRPUVB6THJwZW85?=
 =?utf-8?B?WFNjTWR6RkNtcVlHcldjZ2FtdjZyK01weDdOakIwQUdMaWZPUU9uWVM3cmpp?=
 =?utf-8?B?SHNYTElHbVkwak00V3RmelB1NWhqbC9GTktOS3lqRVBuaVRmRmwzL2duT2dR?=
 =?utf-8?B?RCtiZkpFME1OekJIa3JYdUNqWCswRlBTRDlmNitxUVVaSFZiU0NMQ0VtNzI0?=
 =?utf-8?B?cFVkNXIyR3lNMllLVnpzT2swa01vRDNvOGR2clNTa3NOTHhKUi9CN0lnRlhr?=
 =?utf-8?B?MlNkUnpjOEdYZFFCQmIzOStyQ1djSFdQUnRBZkpVMmhwdHc4cDkvendzYTIx?=
 =?utf-8?B?N1dYci9tanY4Q29FMlhRckxRUUMrOVk4UGR3QXpXMk9sNkRtWUVFVUQrbmlk?=
 =?utf-8?B?YUNJZExNdW1LdDVTM2pxZ3pWYXE5MExkK3Z2ci9EdG9vb3JoVVFPT1ppdis3?=
 =?utf-8?B?czRSWXZlOEhWSVRTV0RXeUJac2kwdFd3bTJxcGdpZC9MOFYwbDFhcDRNU3pi?=
 =?utf-8?B?VUJxd0FlUFpXRWVFQW9NdjZSU0x5eEVuRTVlcDZJcFdoVG1tTmhzK04rbnd2?=
 =?utf-8?B?ZW5rdlZJaUMrTXlPRGRJLzk4ZWNWR0NUNm52Rzc0a1Q0KzZLc0M5V2tJaUo5?=
 =?utf-8?B?aEVaaVBTOUdEV2xWclpPNWtuRFN4U1BsUXhuT1FoVlhuQU96aHFNVS9XYWlS?=
 =?utf-8?B?ajdGOTNSOE42TDd3OWtyZ3J3Z1FydVppOWtUdk9oOVhaeDd6WkYzelNwcVFD?=
 =?utf-8?B?eEl6d2xzSFlXQmV4T2o5aVRvNVNRQ1pKbkMvVldzekQ4cllMZTRJU3NZSDJD?=
 =?utf-8?B?QXhoaERuQm00cER2ZGs3UFRwZG55THF0M21iOGVIM3FQeEQ1c1ptakFXUWpi?=
 =?utf-8?B?VmkzUktmZXA0RHR0M1pBVFByR0ZYa0ZwbjBvRmMyK1IwVmt5RVJSYTRuSkJi?=
 =?utf-8?B?YkdaclFQcnQ1NEw0Z3plc01OOGRxZmVDd2twVDhCQ0xPOVhWVmNzYVMzSDYx?=
 =?utf-8?B?alRVQ2Y4L2E4dWZHOFRFMk4zZGtobVR6K3BHZWQ5S0czNzRYOEhqd1NzZG95?=
 =?utf-8?B?OGV3b3g5M0RVb0poNnUrUERkWmZhYmRTSDdoc21pLzgwYjJ2dkNKcHI1NWpO?=
 =?utf-8?B?TjlwaUlvbnBsSk1BWlVsRnJCL0w1VWdaVHVNUUF2YlZqL3hScGlEZU5HRWtL?=
 =?utf-8?B?Zm4rWGJwZlBVLzk3dklnZkNVUHVrWmloUXR4WWlUM2o0NDlnYk5qbTUwSEYy?=
 =?utf-8?B?dm1ZMkxRSzZZTGsxdmlNS2xsWlpvb0l6OW4yeStpSk0xcGZUVXJ4eXVDWVJw?=
 =?utf-8?B?R1RhaXhnbmc0Nzh1YlJyT2JkWkM3WnZzUHhEUTk2eWlzV2laU3cyNXhsWGRw?=
 =?utf-8?B?WXl5a3NrcmNodTVqUGxKSzZvdlE4Q1pqUFNLL1FFNkZnQUpZTFZqVWRVUXVO?=
 =?utf-8?B?ZkE3ekxPaVc0Nm5lTlVPcTFGbTN0ckp3aXB3VUt0eExoSFg1eG43Sy80Q1FX?=
 =?utf-8?B?WVN0T3RWd3dLUXNyUVVVK3lQM3FTZEpVRW95WHY0L0E3a2xMQzdyUXRGdThH?=
 =?utf-8?B?ZVRwcDRZNDM4aTNubThpRUNOR2JtUFF6RzJUZlhOL3NlVzhqWTZwSEFqMnow?=
 =?utf-8?B?cHhvWVovR3R0ZmFSRjh4d1RpWGVuM3laOUR3dnVDK3dPYTJxOVhSNDI2Tzda?=
 =?utf-8?B?K01NUUhoSENWN1U1MjRiMjRkSnhEdmZwOXpJZHp6Q05kdVcwRUhlWFptRE5h?=
 =?utf-8?B?VGtRejJpTldTajV2b3QvU2JmWXgzRVhjUlZoR1ZJaWZhdy9YU3Q2VzQweWxa?=
 =?utf-8?B?WU0xczc1NWJaZzNxWlRFcVU1QjZNcHpvU2VOOTQvd0tHMVFvQ0hGWHJaWTBp?=
 =?utf-8?B?NlRraWkycnNkVnJHMjMvaWxBYUhDT2lWZHpZUXRHdFJ1YllVOG1Ld1RtYS9K?=
 =?utf-8?Q?9keFd5?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(14060799003)(36860700013)(82310400026)(1800799024)(35042699022)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2025 14:39:56.1701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3fe7de2-f11a-414e-f81b-08ddc79b4bd9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B622.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB10473


On 20/07/25 4:50 pm, Lorenzo Stoakes wrote:
> On Sat, Jul 19, 2025 at 07:16:48PM +0530, Dev Jain wrote:
>> On 19/07/25 12:19 am, Lorenzo Stoakes wrote:
>>> On Fri, Jul 18, 2025 at 02:32:43PM +0530, Dev Jain wrote:
>>> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Thanks!
> You're welcome :)
>
>>>> ---
>>>>    mm/mprotect.c | 125 +++++++++++++++++++++++++++++++++++++++++++++-----
>>>>    1 file changed, 113 insertions(+), 12 deletions(-)
>>>>
>>>> diff --git a/mm/mprotect.c b/mm/mprotect.c
>>>> index a1c7d8a4648d..2ddd37b2f462 100644
>>>> --- a/mm/mprotect.c
>>>> +++ b/mm/mprotect.c
>>>> @@ -106,7 +106,7 @@ bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
>>>>    }
>>>>
>>>>    static int mprotect_folio_pte_batch(struct folio *folio, pte_t *ptep,
>>>> -				    pte_t pte, int max_nr_ptes)
>>>> +				    pte_t pte, int max_nr_ptes, fpb_t flags)
>>>>    {
>>>>    	/* No underlying folio, so cannot batch */
>>>>    	if (!folio)
>>>> @@ -115,7 +115,7 @@ static int mprotect_folio_pte_batch(struct folio *folio, pte_t *ptep,
>>>>    	if (!folio_test_large(folio))
>>>>    		return 1;
>>>>
>>>> -	return folio_pte_batch(folio, ptep, pte, max_nr_ptes);
>>>> +	return folio_pte_batch_flags(folio, NULL, ptep, &pte, max_nr_ptes, flags);
>>>>    }
>>>>
>>>>    static bool prot_numa_skip(struct vm_area_struct *vma, unsigned long addr,
>>>> @@ -177,6 +177,102 @@ static bool prot_numa_skip(struct vm_area_struct *vma, unsigned long addr,
>>>>    	return ret;
>>>>    }
>>>>
>>>> +/* Set nr_ptes number of ptes, starting from idx */
>>>> +static void prot_commit_flush_ptes(struct vm_area_struct *vma, unsigned long addr,
>>>> +		pte_t *ptep, pte_t oldpte, pte_t ptent, int nr_ptes,
>>>> +		int idx, bool set_write, struct mmu_gather *tlb)
>>>> +{
>>>> +	/*
>>>> +	 * Advance the position in the batch by idx; note that if idx > 0,
>>>> +	 * then the nr_ptes passed here is <= batch size - idx.
>>>> +	 */
>>>> +	addr += idx * PAGE_SIZE;
>>>> +	ptep += idx;
>>>> +	oldpte = pte_advance_pfn(oldpte, idx);
>>>> +	ptent = pte_advance_pfn(ptent, idx);
>>>> +
>>>> +	if (set_write)
>>>> +		ptent = pte_mkwrite(ptent, vma);
>>>> +
>>>> +	modify_prot_commit_ptes(vma, addr, ptep, oldpte, ptent, nr_ptes);
>>>> +	if (pte_needs_flush(oldpte, ptent))
>>>> +		tlb_flush_pte_range(tlb, addr, nr_ptes * PAGE_SIZE);
>>>> +}
>>>> +
>>>> +/*
>>>> + * Get max length of consecutive ptes pointing to PageAnonExclusive() pages or
>>>> + * !PageAnonExclusive() pages, starting from start_idx. Caller must enforce
>>>> + * that the ptes point to consecutive pages of the same anon large folio.
>>>> + */
>>>> +static int page_anon_exclusive_sub_batch(int start_idx, int max_len,
>>>> +		struct page *first_page, bool expected_anon_exclusive)
>>>> +{
>>>> +	int idx;
>>> Nit but:
>>>
>>> 	int end = start_idx + max_len;
>>>
>>> 	for (idx = start_idx + 1; idx < end; idx++) {
>>>
>>> Would be a little neater here.
>> I politely disagree :) start_idx + max_len is *obviously* the
>> end index, no need to add one more line of code asserting that.
> Haha, well disagreement is permitted you know ;) as long as it's polite of
> course...
>
> That's fine, this isn't a big deal.
>
>>
>>>> +
>>>> +	for (idx = start_idx + 1; idx < start_idx + max_len; ++idx) {
>>> Nitty again but the below might be a little clearer?
>>>
>>> 	struct page *page = &firstpage[idx];
>>>
>>> 	if (expected_anon_exclusive != PageAnonExclusive(page))
>> I don't think so. first_page[idx] may confuse us into thinking that
>> we have an array of pages. Also, the way you define it assigns a
>> stack address to struct page *page; this is not a problem in theory
>> and the code will still be correct, but I will prefer struct page *page
>> containing the actual address of the linear map struct page, which is
>> vmemmap + PFN. The way I write it is, I initialize first_page from folio_page()
>> which will derive the address from folio->page, and folio was derived from
>> vm_normal_folio() (which was derived from the PFN in the PTE), therefore
>> first_page will contain the actual vmemmap address of corresponding struct page,
>> hence it is guaranteed that first_page + x will give me the x'th page in
>> the folio.
> OK, I don't think this is an issue, but I"m not going to press this, as it's a
> trivial thing, it's fine as-is :)
>
>>
>>>
>>>> +		if (expected_anon_exclusive != PageAnonExclusive(first_page + idx))
>>>> +			break;
>>>> +	}
>>>> +	return idx - start_idx;
>>>> +}
>>>> +
>>>> +/*
>>>> + * This function is a result of trying our very best to retain the
>>>> + * "avoid the write-fault handler" optimization. In can_change_pte_writable(),
>>>> + * if the vma is a private vma, and we cannot determine whether to change
>>>> + * the pte to writable just from the vma and the pte, we then need to look
>>>> + * at the actual page pointed to by the pte. Unfortunately, if we have a
>>>> + * batch of ptes pointing to consecutive pages of the same anon large folio,
>>>> + * the anon-exclusivity (or the negation) of the first page does not guarantee
>>>> + * the anon-exclusivity (or the negation) of the other pages corresponding to
>>>> + * the pte batch; hence in this case it is incorrect to decide to change or
>>>> + * not change the ptes to writable just by using information from the first
>>>> + * pte of the batch. Therefore, we must individually check all pages and
>>>> + * retrieve sub-batches.
>>>> + */
>>> Nice comment thanks.
>>>
>>>> +static void commit_anon_folio_batch(struct vm_area_struct *vma,
>>>> +		struct folio *folio, unsigned long addr, pte_t *ptep,
>>>> +		pte_t oldpte, pte_t ptent, int nr_ptes, struct mmu_gather *tlb)
>>>> +{
>>>> +	struct page *first_page = folio_page(folio, 0);
>>>> +	bool expected_anon_exclusive;
>>>> +	int sub_batch_idx = 0;
>>>> +	int len;
>>>> +
>>>> +	while (nr_ptes) {
>>> I'd prefer this to be:
>>>
>>> 	int i;
>>>
>>> 	...
>>>
>>> 	for (i = 0; i < nr_ptes; i += len, sub_batch_idx += len) {
>>>
>>>> +		expected_anon_exclusive = PageAnonExclusive(first_page + sub_batch_idx);
>> We won't be able to do nr_ptes -= len with this. And personally a while loop
>> is clearer to me here.
> Well, you don't need to :) maybe rename i to pte_idx + pass nr_ptes - pte_idx.
>
> Buuuut I'm not going to press this, it's not a big deal, and I see your point!
>
> Overall the R-b tag still stands with the above unchanged.
>
> Thanks for doing this series and being open to feedback, I feel we're iterated
> to something nice here!

We definitely iterated to something nice! I definitely found your review very
useful; as contributors trying to solve our own problems, we simply keep
adding new features and the code becomes a mess of if-else statements - this
is what I felt when I began reading kernel code. I am reading code and
suddenly some conditional handling a uffd-wp pte appears (I know you have
some nice words about uffd :))

Thank you for actually forcing me to think into how I can implement
my ideas into code better!

>
> Cheers, Lorenzo

