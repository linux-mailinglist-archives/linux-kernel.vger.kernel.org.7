Return-Path: <linux-kernel+bounces-756849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FA3B1BA52
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 20:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278E918A6CA0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B93299AB1;
	Tue,  5 Aug 2025 18:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="tvhk+Uux"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2126.outbound.protection.outlook.com [40.107.237.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA2F295529
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 18:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754419068; cv=fail; b=tiHLZ3BnW/+hJbcmV7DI1zxyhzkxuT0YOXblxrt9gdhfQYrxjDhwHExB7sIDLJOlOKYFu/Hr96UKbJlAds7jHkN96VXkDXUxZXORXEn+Mvn4Z0F3x2NJYMZPtMlZmINDu7N/n0Jm4NDRP33hZXnkeBXL1MJlcnaMyxXEcoNMAXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754419068; c=relaxed/simple;
	bh=poR+3MAgRGejuYkK1ohvsS4AiLGeQxFCUk37zUVd9lc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hLgWGLUTn2wwvfltepLrUka7rDQQ1/Buo7Mjiikh1lQiQh6RRGG0C6n4Pmzjc2Tz0v3nRRf2M2QDoQeK1BY2sNM6nsRvU1zv8p2L2U22p0PmRtWvBX9HzQkQqPv7RcdjbUfh/I01QvtBfvBQK3YIpPMKOWt+0Cz0gMxWbuoZfwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=tvhk+Uux; arc=fail smtp.client-ip=40.107.237.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ub0jnZc3/oFxG2x7XyEUH7cYwepTqxlRM7Iau1oWe2NnACpV7NE9xeAJLyhULaBrIeS9tgrWrn3T07zI52MDWBUp7f9vx3vXcdTOv7EIjqbaBIzBasNOAnqJtsE7CRo8tJobNeCo5SjxpozvvA/JB3dH0/zKvYyAVbb2W0sgsw40FynByjeVDODX0trLy95AbSbPakd/t2QNhMcuj6QaB9DLC3CYKfUrKnE0nNkdk+1a+/0q4P22UpxxueMWbAr2/0Ar0OMgzH65mCmP+xSOjbq4gwToKEFXXnrJAKe3vLH0bU0KdsCkBfOun7SXmIVLNsMZ8AidjkgzdPd64ej3Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1bvXoAg70n0AIjSaPyKdm9sJxuYQ/+3OkvdoKeAHjg=;
 b=AewGIJA9EM4xBM7HMIAh2jvlh0Z2bu/JLfnZ6V8t4sRd8u2C/H5QwZCGJxoTgvem+ziwwNExlqRewh+5m/db1G7CPDDCtNfwnDW7RPLGWSxe0Jdnn8WQfe2GazsDEZmq+XaL/fTWsg6GOmrhdYAXP/uwxWcg8D3JKg7cBtq9Tf9AI0rov4t2O/2w7UwA1nWbdBTCYlsgphhV9Htw/b9K9SBCcUd9TBQI7iX/OcEQFBOO+tz43g86LHWZbw2E7sxoFRf8XuPZV3JHnAkhDyP/kP0oEpoSupFCWWobJGBuqdMzoKIsIkeiIhAuLaGAsvcoDzUi2lqiNwBGhS9Z9OCKrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1bvXoAg70n0AIjSaPyKdm9sJxuYQ/+3OkvdoKeAHjg=;
 b=tvhk+UuxnyjjjQvq6wqnIalE5A/lOmSv4Pw3j5ecR6XpigRwQwUvITAiyKkDQHWYFPv1Ia8fFNeDt4F6NjEzrg2A3J2O1TfS+4P9yPY3V1WOmF4BaGHoUqoIlf215qclYoGdHwHju+/F4XE0wv9Iz46iTxOj2yhwJS3imuy7Ido=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CH0PR01MB6892.prod.exchangelabs.com (2603:10b6:610:105::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8989.21; Tue, 5 Aug 2025 18:37:42 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%2]) with mapi id 15.20.9009.013; Tue, 5 Aug 2025
 18:37:42 +0000
Message-ID: <447d4ee9-bf63-44f0-a064-fea5a5f1acef@os.amperecomputing.com>
Date: Tue, 5 Aug 2025 11:37:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6 0/4] arm64: support FEAT_BBM level 2 and large
 block mapping when rodata=full
To: Ryan Roberts <ryan.roberts@arm.com>, will@kernel.org,
 catalin.marinas@arm.com, akpm@linux-foundation.org, Miko.Lenczewski@arm.com,
 dev.jain@arm.com, scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250805081350.3854670-1-ryan.roberts@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <20250805081350.3854670-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5P221CA0083.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:930:9::17) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CH0PR01MB6892:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e93b32b-34cb-4554-f6ab-08ddd44f2975
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VHUrTDFGV2NiWmxhL3RNVnkzb2ZQaXdGL0ZGUDNSaVVhUzBFbjRFM3BlSGF6?=
 =?utf-8?B?QWF4bis0RXJkbkl1ZnhhV0k2T2tIQnBEVXRiWFUxcGhpSHVaa05GL3Bka00r?=
 =?utf-8?B?RjRpdm16eU9sRk1EYnpXdS8rVUxjQ0t6M01HL2o0bkdyNkxuaVU5Q0t1dHJ0?=
 =?utf-8?B?eTFhbUYrTFBJWUVJMUxNNFZ3eU5GdlRIMWFiejBONUhiRzhxbFNiVW8vMWpl?=
 =?utf-8?B?Y3BoR2lmTlI1bC82dGEya1ArcUNLc0p4bVJ0cUpMRFFCd0lySjNMNnRvckpD?=
 =?utf-8?B?Mlg1cUs1M01NOWJzZVF1Y1dtOG51SUdWOFRDU1VZdm9oaGdUeEJVTkFOZEpn?=
 =?utf-8?B?RnE4ZmFFaTNQQnFra2p5d2VVSHZVK0RaRXZLYWJST3NpNmJWaTFNcGFGdGNz?=
 =?utf-8?B?T2VwS2ltY3FWZDF4NUZoakdPOVpKNDJpZ1JkeCtYenpPTWcycURqRmY0U1BU?=
 =?utf-8?B?UG5Gc3gyaFVmamppY3F2ZVptZHBMOEpraUNqNU9KMjk0bG8wUmN5NDRkMTc0?=
 =?utf-8?B?ajAzSVlNamt6TFozTk9Ed1BxOVB6QWdIbFdwbVVpRk1NVkdyZUdVaGk5aG1H?=
 =?utf-8?B?MXVQUkVjYTgxNGRGdVgwUGZHTEZCbHErUFA0aXBPdnFoSjNiR09pY2t2alpP?=
 =?utf-8?B?MFRvUFNOOUZ0cTFlRFp4RjJZa1cyNzRWbGRnU3V6Z2lRdHNaeFRBZmt2d25p?=
 =?utf-8?B?RXpXT1BpeUMrZUlGeVc3UFp4STAvdVpkRWdzUitkUTlqQThZRDNEYzNISEtL?=
 =?utf-8?B?U0syV3B6Z1NQSkRCbEUxQzdJZVVBOWNHdWtjWmRMcm80c1h3OVpHS3UzdXJR?=
 =?utf-8?B?SE9qMGt6ZHhkY0VnKzY1Zmx6WGFzQ3h1QnlycEIvNG16OGcxWEErNWdsc2RO?=
 =?utf-8?B?SVNRM0pjMzJEQkVCbk4zaTh3c1pyMWV1OTNVTnFvcHV1T2JnOFFCU1BTc2lx?=
 =?utf-8?B?cGFROC9UVFd0R2djZGZPcDI0Qmp6SzhlT2RPS3dWczhwYWpTcXRIc2p0a0Yw?=
 =?utf-8?B?ZlArWm90Nmw4UitCUU9qdUV2dGNidzZVMndWZjdPay93bWs2VldGRjNkQWl1?=
 =?utf-8?B?Z3ZGTU42M2NjeklEZDJDeklXdzFsWUYzMytZR1pRYlExTCs1ZGZBYytWRHA5?=
 =?utf-8?B?cUYwa1lNNnVSWGpjUVpRV3gvbEM1alcydzc3VlN3V1V4WU92VmxCQi94bUpQ?=
 =?utf-8?B?OXNoMW55MXpYUnR4S0VQS0RKN2g3Tk9ja0g2QWRIaWYwcXNiTVZ1S1RpZFBq?=
 =?utf-8?B?MVhTQ2xydzh6UzRPZnBwUnNBMWpqNVYzRE5vWWx5STlrTmZoN3N5QXorRE1j?=
 =?utf-8?B?TktVVncyNWdXN09maVJtdS9oUHdJYkdZcnRNSnVZcUdxTWc0cTZtZTU2YWg0?=
 =?utf-8?B?ekNxazJSdGNrUWtPOU9KbFQzWUYxM3k3eFhaNzRnVnVhK2o5aTJLcnJ3Vkhn?=
 =?utf-8?B?NVB6bnlJQ2FtaXdYOU8wUDUwTHZQOWNUbDVhVG0wUE9xdkVXekJETnZTdVJP?=
 =?utf-8?B?eFM4NzhyWDR1anVha2pNbEpnUjViblpwQ2IyeVBxRy9mNVhqYzR4RGMveGlz?=
 =?utf-8?B?bFZBaDd4eG1vQ0J6WTJ5RlNQTXNmdjNtMXdSUXZ6VWpKdlpEb2tIRjl5Tndr?=
 =?utf-8?B?b0JHclZNQjJQVmgzb0Nmc1h6S1hIMGF2akp3bnMyeVo5aWZTaC94alRRNDY0?=
 =?utf-8?B?bkFmSEVHdVJCNXBVTjgxTlBlZ2pzekJUbUJIV1NTcGVoT3JpQnNaN1M4UnBC?=
 =?utf-8?B?UVhBUXUxTDk1Um5rVERPVFlKYU8wU0Zmb3cyMHZJSFNENUFuVGs0VHVWRkNE?=
 =?utf-8?B?WEtScDFreEUxZXN2eG9CWE9jNlhpamVhTVdLaEFYUU81eVRpc0t2dTJJMHB6?=
 =?utf-8?B?azZBMXRlQ0l2MDFGR2FFOWxTTGFzWmVTajRiTExkbXU3Wmd4OVEzcTNaMGJx?=
 =?utf-8?Q?/kqU1AHNmXw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aldDc0NJQTQxakJpNGRmb1VzR21DaEVsZmNzNVhpcUllczB5Z1pRdk1xYzhX?=
 =?utf-8?B?eHF6cnRDUDdYNWlvMUxUYUxrVFQ4NkdhY0QwU0crbk8xZmtnSGdkL2d3Q3Yz?=
 =?utf-8?B?UnBxVS9mWmF2ZFZya3AvT0JpdTVONzIrNXJOVzFTTmcxbG9XaTNrYXFlaXJH?=
 =?utf-8?B?dlVucW5hQUlnZHMwbFFMdHFoaktyTnhsUjFNZUY1cDBNcmFFZFNkRnhhN3hR?=
 =?utf-8?B?NGVaOEl6QVhDRTZYMWxmeFhGZklzUTJqQk5hRE90QVVqM1VXTyt6S2xVMXRO?=
 =?utf-8?B?SlR6Z1UrcjdiMHBOY2RuWitGMCswQ2hWYWsySEoweXBHVU1IakRYcGlKaUEr?=
 =?utf-8?B?bCtVS1g5Zjhpa2VBTWwzOHRsRUYxRS9YSFlPMXRnSUVQWVVnVytDZmkzTjlo?=
 =?utf-8?B?dWFZd1JsNU5MejlMd1RjaU9maWNCTjRvbEx2eWtXa1cvTjY5dVdEMjJSZSt4?=
 =?utf-8?B?dURNV05lTkNJckVLMFVDU1UyRHdwdGlCbCtneUV4Q0lEUjhqOUF5YmFEWFNZ?=
 =?utf-8?B?NldQb0pySENLamRTM3hkUUgwbEc3dTZIUkI5eE1qZ3RXR0I5cDkzeEdwcjh6?=
 =?utf-8?B?UkdZOHB2NWZSUjBaSlFkSmJDK0s2YVJkUXVCYTk2ZzRibUc4WkROcTJJYkpz?=
 =?utf-8?B?UytUSTl5U2VuZ0IySWZ6SUt6Yk5rUVBWZVR2Ulp1Nld3RWp4bURDYUtua090?=
 =?utf-8?B?bnpTZFpra0RyN1haUFA2blFZYVF1aGlTTlpxbTZrK2pzRURnRElTNFdtbDJU?=
 =?utf-8?B?TnNjY1RxZ3dFWVV5WVZ6TS9YeksvQW1STUFCQVY3VWtVUzdNbGRZQjNVMzha?=
 =?utf-8?B?cEJYSC9qakRZSDJnVUh2QUZXSTYxbmZ6WTJLUkdqN2dhUVhFcVp1L1NKSTJv?=
 =?utf-8?B?YkpuY05xd0c2Mm91cVRscHNPVlNROFluYXp4MHJIMXZzdVQrZ3plQmRkRmJy?=
 =?utf-8?B?M3J2STZXNm93Y2g1R1BVZ0I5S1RFTzdyK2dUT0JrZm5JUlZQelR2L1Z5ME4y?=
 =?utf-8?B?UmJ6NUJBd1pad1RNNXRuQW5mbjV0eWdDQVdoaEdpZ05hZ3N3N3FQZ1QyNHc3?=
 =?utf-8?B?ejBqTDlTOW91aVRNSVBkMkNtM2pTc01jbHl2bWJKZ3RGbnZqZXJYSlpIVUJs?=
 =?utf-8?B?UGJZYWxUblBxdUtFZGQrYlZ4WGtqNEE3d2tYQkVneWdSRUNyeUozMVpMNFdk?=
 =?utf-8?B?OVVyQlZWSXo2SE03OVllZFBJME9VVlNRTHBzM0YvNXNRWFozMklaV3M3UEx2?=
 =?utf-8?B?VFpsTnBzMysvYk9JNmFVVmttZmp4Wkd6UzVqaU9tSUIxeW4veERPUkRKOFRY?=
 =?utf-8?B?K3JlUjlwNEdQYThiMGlwcWRqSWZiMVF6UjQwNCtLR25BWG1LNWJ3RVl6aUF0?=
 =?utf-8?B?TGtTeGE5NmlhUzRCZUx2Zjg0R2YvejAvcW9HazV1OVczZ2R3S0FNWkNUempn?=
 =?utf-8?B?eEZ5bUdhTnUvaFRHSWttckpQNkpsT09BVjVBQTNQWDhiODVlL1lNdkdKYkZz?=
 =?utf-8?B?d2NNVWFOYmpVdW9Jc1dsSDhoOUNRdWxPNms4eXRvaE5yOVF3Y1V2ZllrZDgr?=
 =?utf-8?B?UGpjZEtzQ1lLRkQ2WEJmREhMWnc5WGZiWWs3U1lVekxKQnFsN0MwWTF0TzFo?=
 =?utf-8?B?ZTF6djFKcjV1Z3N1WkZSRjBhenl6ekcrbVl1cW1rSkpNWTBUeGt2WG44aUor?=
 =?utf-8?B?OUZ4WE9GU3MvRExZRE1ma1RodzZ0bDJOQU1pYXlyS2FMN0poKzB6WXYxNkJJ?=
 =?utf-8?B?SGNGd0Q4c3Q4aG1aMFZHWWRldGZzVGg2VVlpQVd2RjV3Z1JPc0J3VGVGS2FB?=
 =?utf-8?B?WFcvVXhLZVNMbkhOKzFNMi8wMXJMeHlNWGJQdlhacUM0NGIvN3dWdEtPS2Jk?=
 =?utf-8?B?MGRONFBrWis5bkJYaHhMZW9SN2RMMkFkVGhGNVpwdVYxd0ZFVnFPNWVDRUpO?=
 =?utf-8?B?L2RIczV0MzVxVFBQR0UvaUlVaGFPUFlicFVxM0piQVFnZUVyWGFCK2xvcFdW?=
 =?utf-8?B?N0xmdHJNMUxLQlhaeE5hbVhXM09CQ1NSMWxhVXVaYlVmcHNWclJsQzh1WGth?=
 =?utf-8?B?cGQ2emFPSUhSL3U1dkFKMnBiRGhhVlJ1WWsvb0xPU1JOY09OY21uR2FVeURt?=
 =?utf-8?B?TlJNZjVFVkl1dENvaWl2RmQrZm9DZmxGZ1orOTQyQk1ZRTZLc2RXK004WkdH?=
 =?utf-8?Q?VlprUvhc9DmNd4yKJemN3MQ=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e93b32b-34cb-4554-f6ab-08ddd44f2975
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2025 18:37:42.1217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UbOIrSrld7N87bHbxQsL2MPyDJXgfqTF3hF3I9ax2dqb6EYGb8LwVtdHPtJfuxrwzQKF/Ec0jRj2WWKlN/X7QwDgYMeyTtOGfYDkf7gTsxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB6892

Hi Ryan

On 8/5/25 1:13 AM, Ryan Roberts wrote:
> Hi All,
>
> This is a new version built on top of Yang Shi's work at [1]. Yang and I have
> been discussing (disagreeing?) about the best way to implement the last 2
> patches. So I've reworked them and am posting as RFC to illustrate how I think
> this feature should be implemented, but I've retained Yang as primary author
> since it is all based on his work. I'd appreciate feedback from Catalin and/or
> Will on whether this is the right approach, so that hopefully we can get this
> into shape for 6.18.
>
> The first 2 patches are unchanged from Yang's v5; the first patch comes from Dev
> and the rest of the series depends upon it.

Thank you for making the prototype and retaining me as primary author. 
The approach is basically fine to me. But there are some minor concerns. 
Some of them were raised in the comment for patch #3 and patch #4. I put 
them together here.
     1. Walk page table twice. This has been discussed before. It is not 
very efficient for small split, for example, 4K. Unfortunately, the most 
split is still 4K in the current kernel AFAICT.
         Hopefully this can be mitigated by some new development, for 
example, ROX cache.
     2. Take mutex lock twice and do lazy mmu twice. I think it is easy 
to resolve as I suggested in patch #3.
     3. Walk every PTE and call split on every PTE for repainting. It is 
not very efficient, but may be ok for repainting since it is just called 
once at boot time.

I don't think these concerns are major blockers IMHO. Anyway let's see 
what Catalin and/or Will think about this.

Regards,
Yang

>
> I've tested this on an AmpereOne system (a VM with 12G RAM) in all 3 possible
> modes by hacking the BBML2 feature detection code:
>
>    - mode 1: All CPUs support BBML2 so the linear map uses large mappings
>    - mode 2: Boot CPU does not support BBML2 so linear map uses pte mappings
>    - mode 3: Boot CPU supports BBML2 but secondaries do not so linear map
>      initially uses large mappings but is then repainted to use pte mappings
>
> In all cases, mm selftests run and no regressions are observed. In all cases,
> ptdump of linear map is as expected:
>
> Mode 1:
> =======
> ---[ Linear Mapping start ]---
> 0xffff000000000000-0xffff000000200000           2M PMD       RW NX SHD AF        BLK UXN    MEM/NORMAL-TAGGED
> 0xffff000000200000-0xffff000000210000          64K PTE       RW NX SHD AF    CON     UXN    MEM/NORMAL-TAGGED
> 0xffff000000210000-0xffff000000400000        1984K PTE       ro NX SHD AF            UXN    MEM/NORMAL
> 0xffff000000400000-0xffff000002400000          32M PMD       ro NX SHD AF        BLK UXN    MEM/NORMAL
> 0xffff000002400000-0xffff000002550000        1344K PTE       ro NX SHD AF            UXN    MEM/NORMAL
> 0xffff000002550000-0xffff000002600000         704K PTE       RW NX SHD AF    CON     UXN    MEM/NORMAL-TAGGED
> 0xffff000002600000-0xffff000004000000          26M PMD       RW NX SHD AF        BLK UXN    MEM/NORMAL-TAGGED
> 0xffff000004000000-0xffff000040000000         960M PMD       RW NX SHD AF    CON BLK UXN    MEM/NORMAL-TAGGED
> 0xffff000040000000-0xffff000140000000           4G PUD       RW NX SHD AF        BLK UXN    MEM/NORMAL-TAGGED
> 0xffff000140000000-0xffff000142000000          32M PMD       RW NX SHD AF    CON BLK UXN    MEM/NORMAL-TAGGED
> 0xffff000142000000-0xffff000142120000        1152K PTE       RW NX SHD AF    CON     UXN    MEM/NORMAL-TAGGED
> 0xffff000142120000-0xffff000142128000          32K PTE       RW NX SHD AF            UXN    MEM/NORMAL-TAGGED
> 0xffff000142128000-0xffff000142159000         196K PTE       ro NX SHD AF            UXN    MEM/NORMAL-TAGGED
> 0xffff000142159000-0xffff000142160000          28K PTE       RW NX SHD AF            UXN    MEM/NORMAL-TAGGED
> 0xffff000142160000-0xffff000142240000         896K PTE       RW NX SHD AF    CON     UXN    MEM/NORMAL-TAGGED
> 0xffff000142240000-0xffff00014224e000          56K PTE       RW NX SHD AF            UXN    MEM/NORMAL-TAGGED
> 0xffff00014224e000-0xffff000142250000           8K PTE       ro NX SHD AF            UXN    MEM/NORMAL-TAGGED
> 0xffff000142250000-0xffff000142260000          64K PTE       RW NX SHD AF            UXN    MEM/NORMAL-TAGGED
> 0xffff000142260000-0xffff000142280000         128K PTE       RW NX SHD AF    CON     UXN    MEM/NORMAL-TAGGED
> 0xffff000142280000-0xffff000142288000          32K PTE       RW NX SHD AF            UXN    MEM/NORMAL-TAGGED
> 0xffff000142288000-0xffff000142290000          32K PTE       ro NX SHD AF            UXN    MEM/NORMAL-TAGGED
> 0xffff000142290000-0xffff0001422a0000          64K PTE       RW NX SHD AF            UXN    MEM/NORMAL-TAGGED
> 0xffff0001422a0000-0xffff000142465000        1812K PTE       ro NX SHD AF            UXN    MEM/NORMAL-TAGGED
> 0xffff000142465000-0xffff000142470000          44K PTE       RW NX SHD AF            UXN    MEM/NORMAL-TAGGED
> 0xffff000142470000-0xffff000142600000        1600K PTE       RW NX SHD AF    CON     UXN    MEM/NORMAL-TAGGED
> 0xffff000142600000-0xffff000144000000          26M PMD       RW NX SHD AF        BLK UXN    MEM/NORMAL-TAGGED
> 0xffff000144000000-0xffff000180000000         960M PMD       RW NX SHD AF    CON BLK UXN    MEM/NORMAL-TAGGED
> 0xffff000180000000-0xffff000181a00000          26M PMD       RW NX SHD AF        BLK UXN    MEM/NORMAL-TAGGED
> 0xffff000181a00000-0xffff000181b90000        1600K PTE       RW NX SHD AF    CON     UXN    MEM/NORMAL-TAGGED
> 0xffff000181b90000-0xffff000181b9d000          52K PTE       RW NX SHD AF            UXN    MEM/NORMAL-TAGGED
> 0xffff000181b9d000-0xffff000181c80000         908K PTE       ro NX SHD AF            UXN    MEM/NORMAL-TAGGED
> 0xffff000181c80000-0xffff000181c90000          64K PTE       RW NX SHD AF            UXN    MEM/NORMAL-TAGGED
> 0xffff000181c90000-0xffff000181ca0000          64K PTE       RW NX SHD AF    CON     UXN    MEM/NORMAL-TAGGED
> 0xffff000181ca0000-0xffff000181dbd000        1140K PTE       ro NX SHD AF            UXN    MEM/NORMAL-TAGGED
> 0xffff000181dbd000-0xffff000181dc0000          12K PTE       RW NX SHD AF            UXN    MEM/NORMAL-TAGGED
> 0xffff000181dc0000-0xffff000181e00000         256K PTE       RW NX SHD AF    CON     UXN    MEM/NORMAL-TAGGED
> 0xffff000181e00000-0xffff000182000000           2M PMD       RW NX SHD AF        BLK UXN    MEM/NORMAL-TAGGED
> 0xffff000182000000-0xffff0001c0000000         992M PMD       RW NX SHD AF    CON BLK UXN    MEM/NORMAL-TAGGED
> 0xffff0001c0000000-0xffff000300000000           5G PUD       RW NX SHD AF        BLK UXN    MEM/NORMAL-TAGGED
> 0xffff000300000000-0xffff008000000000         500G PUD
> 0xffff008000000000-0xffff800000000000      130560G PGD
> ---[ Linear Mapping end ]---
>
> Mode 3:
> =======
> ---[ Linear Mapping start ]---
> 0xffff000000000000-0xffff000000210000        2112K PTE       RW NX SHD AF            UXN    MEM/NORMAL-TAGGED
> 0xffff000000210000-0xffff000000400000        1984K PTE       ro NX SHD AF            UXN    MEM/NORMAL
> 0xffff000000400000-0xffff000002400000          32M PMD       ro NX SHD AF        BLK UXN    MEM/NORMAL
> 0xffff000002400000-0xffff000002550000        1344K PTE       ro NX SHD AF            UXN    MEM/NORMAL
> 0xffff000002550000-0xffff000143a61000     5264452K PTE       RW NX SHD AF            UXN    MEM/NORMAL-TAGGED
> 0xffff000143a61000-0xffff000143c61000           2M PTE       ro NX SHD AF            UXN    MEM/NORMAL-TAGGED
> 0xffff000143c61000-0xffff000181b9a000     1015012K PTE       RW NX SHD AF            UXN    MEM/NORMAL-TAGGED
> 0xffff000181b9a000-0xffff000181d9a000           2M PTE       ro NX SHD AF            UXN    MEM/NORMAL-TAGGED
> 0xffff000181d9a000-0xffff000300000000     6261144K PTE       RW NX SHD AF            UXN    MEM/NORMAL-TAGGED
> 0xffff000300000000-0xffff008000000000         500G PUD
> 0xffff008000000000-0xffff800000000000      130560G PGD
> ---[ Linear Mapping end ]---
>
> [1] https://lore.kernel.org/linux-arm-kernel/20250724221216.1998696-1-yang@os.amperecomputing.com/
>
> Thanks,
> Ryan
>
> Dev Jain (1):
>    arm64: Enable permission change on arm64 kernel block mappings
>
> Yang Shi (3):
>    arm64: cpufeature: add AmpereOne to BBML2 allow list
>    arm64: mm: support large block mapping when rodata=full
>    arm64: mm: split linear mapping if BBML2 unsupported on secondary CPUs
>
>   arch/arm64/include/asm/cpufeature.h |   2 +
>   arch/arm64/include/asm/mmu.h        |   4 +
>   arch/arm64/include/asm/pgtable.h    |   5 +
>   arch/arm64/kernel/cpufeature.c      |  17 +-
>   arch/arm64/mm/mmu.c                 | 368 +++++++++++++++++++++++++++-
>   arch/arm64/mm/pageattr.c            | 161 +++++++++---
>   arch/arm64/mm/proc.S                |  25 +-
>   include/linux/pagewalk.h            |   3 +
>   mm/pagewalk.c                       |  24 ++
>   9 files changed, 566 insertions(+), 43 deletions(-)
>
> --
> 2.43.0
>


