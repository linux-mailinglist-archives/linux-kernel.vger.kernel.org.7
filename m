Return-Path: <linux-kernel+bounces-751588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61449B16B2D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 06:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A0927AFF2A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 04:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6D820E718;
	Thu, 31 Jul 2025 04:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kruN5W65";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="kruN5W65"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011019.outbound.protection.outlook.com [52.101.70.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E39539A
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 04:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.19
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753936287; cv=fail; b=HhE9QvU3o6DtYsG8rNdahFYQNtV8qmzAP+kV0BOOVnsOM1n3Lf7pPS++xL37FBXLvqyBn9BrSHwzhilOAsX04tbP4ovrZWEYgUdC3u4hLIt0MUmx7SylOaoMrAmIGZnZsFZ8jZL3ymJQ0ZFL2IgEPosiQlIs4H44350eQdHyaxo=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753936287; c=relaxed/simple;
	bh=uuAn1O5vQaA658Poh3teV+J0xoDZFbY8QFHKI19zXY8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VrHuJyf5N4AfdcWPaBuD0dmAFqI08qJCQMOaW6/kiZxNEV8jF4J6ZjRKINPftAobGmhf1U0Mf8fSzMrQS+SnRgafEx7ImruhAHR5A6fMSrXqs3ELSBw16CuyKjTkXoxiId7xvw3oFgK4w6bvRCkxxgLqxhJPWbruz3haOwF0Dmw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kruN5W65; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=kruN5W65; arc=fail smtp.client-ip=52.101.70.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=xtgL09wNPlmaFXfwED3PQH8tmQa5cTW8YTCqMeL3wELU9G+pGyuayzED2e/oKGJJKHpyK70iW4v+dhQ4SeV6BeX2uw6Bo1MiLA1WF64oWdywr7tpTG6Znbbco3+ndkeUH84n/j+CJUvyAXEHLBNjCk0fGp1ZzOLtJo4nnnv2iTGt6mGTLgu6z00q/nRrL3Gynskg2TbNjBws2TrMEkdas4BBdg9YZuIz4qxsZZ95L5E1P0hTTvRLcsyRVR3b3Gqxd3XR47IQnJd0JYPJUdnt9bwKLQhABRhyhDQxRLpfPHGd60EtzvVssvddCCqAO1UKsqVnoYAlgeVcCJrv6G8cKg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJQ3r7wPNdtAMWWi8Kp1rRotLHKfOF4fq+w+djhN+ww=;
 b=sH1oJJm1FKQNsbXHRflurhiusJLX7koHWTguf49SYAFt7wSG1SYrnC/FKzuT4AXDsa+XDbY8OJtoz5xC5Qkn3TTPpoF0tuzQTSH5BYdFRFL/uKANQE5R62qgAUh6Scj7Kljd5G/aVQAVklL4pCUYGeYhQP2I6YJSt3Qq7on4xSCfB8U7uC+gHvgJkukG9VLKM674Ny49TQOy12m3QWy8XvCl0CEV1xhmtPncSshWB0ZXqYk5LoGyG7AgrqVL7oCgflChfP5xckWS5Y5H+DgbARk/gktAChb5TsSNgOqOx4XVxfmVkdBdqjdDAd8s+L2gIX2cqgzDGZYdGN/lZUR8Ig==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=kernel.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJQ3r7wPNdtAMWWi8Kp1rRotLHKfOF4fq+w+djhN+ww=;
 b=kruN5W65kOZxjms2u7W7K3KJYMEKnnZYpThbi8KjVa26XWwe6ykO81whyqt7I2a8CKgdE3IeeMpH5kLgppfRTjs262UefZJTGB2TThcN5b7sYoP7Qd2dyLP0FTMyZx71qgsULoRSe0PswrGWK7aXMSxjxTX0xORtZLkA2DP3t2c=
Received: from DB7PR05CA0045.eurprd05.prod.outlook.com (2603:10a6:10:2e::22)
 by DB9PR08MB6652.eurprd08.prod.outlook.com (2603:10a6:10:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Thu, 31 Jul
 2025 04:30:59 +0000
Received: from DB5PEPF00014B9D.eurprd02.prod.outlook.com
 (2603:10a6:10:2e:cafe::b3) by DB7PR05CA0045.outlook.office365.com
 (2603:10a6:10:2e::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.14 via Frontend Transport; Thu,
 31 Jul 2025 04:30:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB5PEPF00014B9D.mail.protection.outlook.com (10.167.8.164) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.10
 via Frontend Transport; Thu, 31 Jul 2025 04:30:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yzGn2xdCJYgdnvK6PJGEzc0qmvMwRh9tGLPpYJK3UogStgdE9Gfy8vduZjpoI4wPmEVkcO6nELjM+rePSHgOpeFVsEYnz4PclYkU6BlfFOWGRtDR/ElPavE8WjJw3EoIxD1oBUaAK/SROI34pOngzJs9cwO0OTYLdGDWNiWJSADfVx/lhCIHTXvOarY02cqPoPEeR6WVtYVosra8npllnrBGolMc98Grqrx1xguroDrzobnjHNUuaTjCneqY+1lqO+GqixCEAMHJPh0ZwAOFHytHQoFJFsEDpqmnsAeNVsIuNb0L2LOxwSKh0DaOt6SLfWzemh4ycoWce3SBvqyMuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJQ3r7wPNdtAMWWi8Kp1rRotLHKfOF4fq+w+djhN+ww=;
 b=Vi6EixJJUsdEmtEDwFCH+T3En1ffXXMn07Far9wUuGIkXB2j60Zb5n5TokC859bZKH8UXMRBEDJBkcNUm32A8d8hkBqYzEIMkCsmCo7nLbQIJUWHbiQAV3XJV/6rz3n7esFPY/YswnEzWzNdvBLGgjrzdDycud1jiFFQWN4fSHMfkndSMiSpozWOa+I8X48L2C8NAzJy/dIXtAqNT2Fepk2Nw3ycehKk1YNfvmJc/VqxIALPC3Ltc4pVBI2QhLVaB3dC/wT04xM+UC9077ncjKL7GPB/ONCyrEawt7umKr9nx7QgIU8/S6BovNAub2KsAirD6YKiKG4e/k8UTo+QDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJQ3r7wPNdtAMWWi8Kp1rRotLHKfOF4fq+w+djhN+ww=;
 b=kruN5W65kOZxjms2u7W7K3KJYMEKnnZYpThbi8KjVa26XWwe6ykO81whyqt7I2a8CKgdE3IeeMpH5kLgppfRTjs262UefZJTGB2TThcN5b7sYoP7Qd2dyLP0FTMyZx71qgsULoRSe0PswrGWK7aXMSxjxTX0xORtZLkA2DP3t2c=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com (2603:10a6:20b:3dc::22)
 by PR3PR08MB5737.eurprd08.prod.outlook.com (2603:10a6:102:8d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.13; Thu, 31 Jul
 2025 04:30:26 +0000
Received: from AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e]) by AM9PR08MB7120.eurprd08.prod.outlook.com
 ([fe80::2933:29aa:2693:d12e%5]) with mapi id 15.20.8989.013; Thu, 31 Jul 2025
 04:30:26 +0000
Message-ID: <20ab00da-e85d-4f18-b482-bb406275693c@arm.com>
Date: Thu, 31 Jul 2025 10:00:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH v5] arm64: Enable vmalloc-huge with ptdump
To: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: will@kernel.org, anshuman.khandual@arm.com, quic_zhenhuah@quicinc.com,
 kevin.brodsky@arm.com, yangyicong@hisilicon.com, joey.gouly@arm.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 david@redhat.com, mark.rutland@arm.com, urezki@gmail.com
References: <20250723161827.15802-1-dev.jain@arm.com>
 <aIpPsg1Kij8Knnjl@arm.com> <8f89490b-bac5-4297-a4a8-9e9c4a8f5ef5@arm.com>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <8f89490b-bac5-4297-a4a8-9e9c4a8f5ef5@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0040.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:175::13) To AM9PR08MB7120.eurprd08.prod.outlook.com
 (2603:10a6:20b:3dc::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB7120:EE_|PR3PR08MB5737:EE_|DB5PEPF00014B9D:EE_|DB9PR08MB6652:EE_
X-MS-Office365-Filtering-Correlation-Id: ae3812c1-78f8-47a1-3ed4-08ddcfeb0c86
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?dXNRZ0hseHJMYi9aMmZyQTJTdGJNZFZZSDFEczNDUVVEdHZWUlFLN2NJeFpq?=
 =?utf-8?B?Yzd3aTc4M1dXaGkzMDQvMDROOUNobGw4MHZ0bGFFN3NxZlh1ZmxST1h1a01k?=
 =?utf-8?B?ZmJySXlpbml5bGhZYWVSUGlEdFRJT2RNOEw5WXcrc0JvUXllSG5xTVVvTkNG?=
 =?utf-8?B?R1BoS3lCY1dWby96cTluWWNaYmhCMjZtUjN3NVFkYnk2NnBSOCttR1pSdU1C?=
 =?utf-8?B?azZRSmRMWEhVWVMrUWlqYjAwM0hnT3JjYXFVNVZpQnlzd21Dbit4WFNHRFhv?=
 =?utf-8?B?MTBsS3pramh5MzBybm54OUpMUTJRUlZXeWJyQUZ4Q3dJcHZaTGQ2RzNid0Zw?=
 =?utf-8?B?SlNYWktoK1dxMDROVUhKaEh1SkFwWE5oRmJqMEJXNkk2TERPUWlIR2xmQlQ4?=
 =?utf-8?B?VFd3Y2ltN3lpQ21zREw5dXBkUWhuTUd6WWJvaHloRWozQ0dIaG1kRmZpbjF5?=
 =?utf-8?B?NUF4WGFDZGVjYWVMUUkya0FHNENWODNNU08vMHFiNkkyUUNBQWI3Y1dsQVpU?=
 =?utf-8?B?RzQ4Q0kwOU5PbEF4WVpQMTlHQ0I1MDQ3YTN6ZVFnSkhhTVc2K3B2VEplT01J?=
 =?utf-8?B?QzNPSDNBTVhIZENXYzdVSnJCZzdtVjhGaU0xSXJRQzVKTFo0bW4xSXZaQ3NY?=
 =?utf-8?B?bmNQUjMyNFVDZXdDZlZSdGZmY1AzMWVYeFhOelNWelJLR2U4Y3h5eFg5RFJk?=
 =?utf-8?B?TzY4NHZOUFFEZHZWTTF4dGwwdUtiNG90TlB1UXJTdDExTWlRYzREdkVnam9F?=
 =?utf-8?B?c1laeWhJYTF6ZHllengvZUVuRE40elRUL0R6eWRaTkIwMkczc1lpNE41eWpj?=
 =?utf-8?B?NHpreEEwUDU1VFU4MGt4UFVxOGwvYUxsc2syNWhaT0g4bTdMTVZTM20yQ1Vq?=
 =?utf-8?B?OXFtaUtvNGhOeDRPalFGMll2UGRHckdjRUUzb1c3NmdZVTJHSWo2d1RTbFBK?=
 =?utf-8?B?d2dob1JkNlI0b3V0dEc4bXhhYXhPRVlzZUlyU1pNWHlkQ2N4VU5rYkdUNlho?=
 =?utf-8?B?S0VYWit4YWEzRi9lNUs4VXh5UE55RlVQYmx0WEIyaUl3aFZDcWlMUzdGbVZp?=
 =?utf-8?B?SFZlaHU2S1o5b2h2NlNxVlRRYkJjNDdhcFBWSUI4NFJSaTBodlZUQVlrTlEx?=
 =?utf-8?B?ZWh1VlhZeDdzdDNlS3VxeE9FeS91b0N1KzhGQ2U5bE5YNHJtT2RiMEg0M1dy?=
 =?utf-8?B?MzNaZElsSUFaYjFMY0RnZ2o3bzdxdXJtQjB3ZHBWYlZ4WjJDY3MzS25IbEVC?=
 =?utf-8?B?NzVVTGlwUTdtZTBLcW9vNHpWNllxQ2J1T2MwYkMva3NhajhmZDFkb2ZjNGNE?=
 =?utf-8?B?UkhDZWJzcWhjZWJ6eE80VlRiV2FFcUpGTGhKdVl1TWZ5elViMEZkLytjVGh5?=
 =?utf-8?B?SmdiTGU4a2dzSGU0VkxRejN4cGdiRkNMQzZBTWF6MWNkVmdBa3J0ZE13Qnky?=
 =?utf-8?B?S2FxUjJTSmEyNHpFSG1xZkt4SHYvOTJJMjBYaGZiMlRQODVzUks5WGE4clZp?=
 =?utf-8?B?V3RQejlUM3dkSEZ5c3NzRmEzVTFZUWRFaEE2ZncwdHFNWFkvRnQrQ2Z2Q2pG?=
 =?utf-8?B?cHVKdDJWNFNsU2JMc1hzNTlLbTNEZ004aHhHY0VRVGtjVHpJNXVkbjVlRlM4?=
 =?utf-8?B?NXE4Q2V5cXBST2E5RGM1NGsvNnhjQXVIR0Z4blNURGszYjA5M0ZyV3JzTXRS?=
 =?utf-8?B?WFVONmQ1b3ZFRVJMUGMyZ3NUNFpZN3lsS1hySFIxanBzTmtzTDU2ckRiWDZS?=
 =?utf-8?B?YUhybmJyT3AwbkJOcVdkRW1HaHk3U20wY0x6akdYdTIwbmtuaTZybTVkMGcw?=
 =?utf-8?B?bU1BS2JQbUptZStxdWNEcS9wLzJtTjU3ZzR1ZDBNblJtdm8vVkx2bS9vUkQv?=
 =?utf-8?B?N1ZaUkNyd1p4UXRkR21xYzJiT0cwOVZFck9USjcwblNTZEl3cm1VNlVEaVFH?=
 =?utf-8?Q?Z4nH2CooGgc=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB7120.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5737
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	733eb3e5-a4d5-4141-9b56-08ddcfeaf8bc
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013|14060799003|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZEV0K0VuL1dSYThwaXVjOFNsSVljdHNhdHg0TE5ZMTRiMnRXbThET3UrWFQ5?=
 =?utf-8?B?bkx4YVRSK0JEMVpRZStvVlFZSzdvNSt6cDNRWC81M0pNZEk4Q0ltVnpCYjQ4?=
 =?utf-8?B?cm43Sko3V1hiam1HdTcxNVZwZU85QmNVM1crUXNUZFo2U0Q0TWRNb0xaMGMw?=
 =?utf-8?B?ckF1d2hwTzdIaDNTRGlXdENFUE8vclZnVWdJa0NtU2xxd3QyRm9DVjRxdXlS?=
 =?utf-8?B?MXcvQXpOUHJxZndmMjRBZU04d0RvY0gvNkk3a0NWSC9hZHJlc2d4WEVQUlBw?=
 =?utf-8?B?VjhKK1B5ZUZKRElOZVVzdU1rWW9ldjhtK1gvbng0dzcxMDFwa1JUU3ZPSU5w?=
 =?utf-8?B?MjMzQ3kwYjJaZ2RBcWl4ZjlKQTVZVHdBVjYxbk1FaTMvSEJ2aW5yY1ZtaTNv?=
 =?utf-8?B?QnRzVUdnY1Bya1lJa0ZJbFRRNUV0Z0FZVUoyTFlkWnZseWxDNm1UYytHSU5k?=
 =?utf-8?B?d3I5MFhrUVBOclVxcEdOK1JSNjBKcEk0OHNJRmZKTk0yNUU0MXVSb000T2Iz?=
 =?utf-8?B?dE4zMGlHU1pDN1V4OHZnSFlOcXdYR0lQakxzV1lxUU0yck0zWVVxeGxCT3Yx?=
 =?utf-8?B?M2JRY0dBL0k2cGJhUU4xTGk4RzVOSkpoN3pPblRGZmhtUTZaWm9KRWw1NHN3?=
 =?utf-8?B?enNha0VvZDRuQ3hpVTNOM09uZVRwRGVXTGRhS3cwdllOdzI0bVZhL1YvRWJl?=
 =?utf-8?B?YWNGYkpLeDlhSnRvQjY3MDI4MmtVanZWcjBESmhCM2FpdDllRm5lNFU1NHRD?=
 =?utf-8?B?ZDYrd0FiZjVhR0JPc3N5MVIwR1ZJbUF5STFyLzRoOTB5Y2xhanRKSWJzVkt1?=
 =?utf-8?B?TkUyKzg2cGhPMW9CZlczNDhsU2JNcW5PUnNnN2U4SDIvUzdJUjFMODdaVWZS?=
 =?utf-8?B?Qmt5NGFOUVlsd2VOTUQ3ZmNPT3d1SjE5VE1PQkFYWWxTRG9ZT2NMb2xFT0ds?=
 =?utf-8?B?NWdzOEZqWmN5eWsrNHdhQ2NhMmxvS0JGenpxdzJQTHVLUUpjZmZFTmtUcC9j?=
 =?utf-8?B?cVZ4bVpMa3VrSi95dGtvRE1XcUE4MENaMWtUaXdybVlibElCSE0vSXZXZTZq?=
 =?utf-8?B?SFdOMUZGRzZ0MWppa0Zka0xOVnQ1VDBOdzVadmVRTXFpYWs2MzF5aW9hMHBY?=
 =?utf-8?B?WjVIMVk5Wkt6QUlVd0p0c09TZGpwemRYaGRRSlQ1bjQwM3p1VGY0VkxlQ0t2?=
 =?utf-8?B?ZTBVYTIwSkZ5TzVrMGFZMHVRZWh1amRvek1NWXFWKzV1VzBTaDZRYTlUMUtj?=
 =?utf-8?B?cHJxcXprVDkzTEtBVThoQ2lORHA1TElWUVk0NnBMVjdackdDU2t2UWxyMzRz?=
 =?utf-8?B?VHc3b3FWeHhVdE9zQVdOL2E0NGdXd3pyS0ZMakdNVnZNWHpXY0t5dFh6dzIx?=
 =?utf-8?B?K2Q5QlozbHQxTFFxNHZEYnhUY3hSWXRWTWNxRk1zRTJhY3lURms1c1A0SDY3?=
 =?utf-8?B?WkJ5TUhtdWdQZEpoU3kyOGFvVk1MclhDbUJhc3N2bzRpOWdDeEtCWnBJNVB6?=
 =?utf-8?B?RFJHQmVTSU9mQ1JjK0ovdVFmQ2pZL0hRY21ySXlFY2NGU0xtWGlvdDNGS1FV?=
 =?utf-8?B?dXJrWm9vOVphTHdmSFNoTkZINXBIc09GN0VrYkRLUHJhckFhUkluaEtDTmRO?=
 =?utf-8?B?Z0RvTUUxODFCS0p0ZFNtazZIWGdEakdIQ214bVZodmhCNkxIL3FDa2JsK0N6?=
 =?utf-8?B?TVpTZndocy83M0xFN0lRbmFFdTVXYUFvUDNMdFU2dDl0RUhXanBMYlNTbDU0?=
 =?utf-8?B?SG9vam15blM2TUVNeVg3V2Z6MmhaM0VrWTJDRTVlUWxwMVlZZE1yTUF3aWQv?=
 =?utf-8?B?UHU1cVd0aCt4Q0xKMXZHRmd6elhMOS9jOFR4aEpZQXNzL04vWWhwUmk0VnZt?=
 =?utf-8?B?cS90Vkg3c0gyajlsVDRjaG9udzNZKzEzQ2krVWNta3RJY3BYZ29pNXBmNExL?=
 =?utf-8?B?MVFuZTNXSndaZUlpNUgzRFZXM2JZTHVrdHpjQXh0TGNBMEdaSUdyMUROb012?=
 =?utf-8?B?bTI5UW5vTngwa3JHTnFGN3p4aHlxS2o0eSs5Smo2Ymxtd2UxR3R3c2cxUE91?=
 =?utf-8?Q?FAfEJT?=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013)(14060799003)(35042699022);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 04:30:58.9897
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae3812c1-78f8-47a1-3ed4-08ddcfeb0c86
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6652


On 30/07/25 11:59 pm, Ryan Roberts wrote:
> On 30/07/2025 18:00, Catalin Marinas wrote:
>> On Wed, Jul 23, 2025 at 09:48:27PM +0530, Dev Jain wrote:
> [...]
>
>>> +	 * mmap_write_lock/unlock in T1 be called CS (the critical section).
>>> +	 *
>>> +	 * Claim: The CS of T1 will never operate on a freed PMD table.
>>> +	 *
>>> +	 * Proof:
>>> +	 *
>>> +	 * Case 1: The static branch is visible to T2.
>>> +	 *
>>> +	 * Case 1 (a): T1 acquires the lock before T2 can.
>>> +	 * T2 will block until T1 drops the lock, so pmd_free() will only be
>>> +	 * executed after T1 exits CS.
>> This assumes that there is some ordering between unlock and pmd_free()
>> (e.g. some poisoning of the old page). The unlock only gives us release
>> semantics, not acquire. It just happens that we have an atomic
>> dec-and-test down the __free_pages() path but I'm not convinced we
>> should rely on it unless free_pages() has clear semantics on ordering
>> related to prior memory writes.
> I can understand how pmd_free() could be re-ordered before the unlock, but
> surely it can't be reorded before the lock? I need to go unlearn everything I
> thought I understood about locking if that's the case...
>

You are correct, what Catalin is saying is that my reasoning has a hole.
There is no obvious ordering between unlock and free(), but

mmap_write_unlock() will happen before mmap_read_lock() ... (i)
mmap_read_lock() will happen before pmd_free() ... (ii)

which lets us conclude that mmap_write_unlock() will happen before pmd_free().

A more rigorous way to write this would be (for Case 1):

T2								T1

pmd_clear()							5. cmpxchg(enable static branch)
1. while (!cmpxchg(check if lock not taken in write mode));	6. smp_mb()
2. smp_mb();							7. while (!cmpxchg(check if lock not taken))
3. smp_mb();							8. smp_mb()
4. cmpxchg(release lock)					CS instructions
pmd_free()							9. smp_mb()
								10. cmpxchg (release lock)

where: (1,2) = mmap_read_lock(), (3,4) = mmap_read_unlock(), (5,6) = static_branch_enable(),
(7,8) = mmap_write_lock(), (9, 10) = mmap_write_unlock().

For Case 1(a), 7 succeeds before 1 can. So, 1 will block until 10 completes, so 10 is
observed before 1, and 1 is observed before pmd_free() due to the barriers. The associativity follows.


